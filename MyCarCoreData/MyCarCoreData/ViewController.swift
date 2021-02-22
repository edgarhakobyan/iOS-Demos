//
//  ViewController.swift
//  MyCarCoreData
//
//  Created by Edgar on 20.02.21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var context: NSManagedObjectContext!
    var car: Car!
    
    lazy var dateFormater: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .none
        return df
    }()
    
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var timeStartedLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var numberOfTripsLabel: UILabel!
    @IBOutlet weak var myChoiceImageView: UIImageView!
    @IBOutlet weak var carSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        let isInitialDataLoaded = userDefaults.bool(forKey: "isInitialDataLoaded")
        if !isInitialDataLoaded {
            loadDataFromFile()
            userDefaults.set(true, forKey: "isInitialDataLoaded")
        }
        
        updateSegmentedControll()
    }

    @IBAction func startEnginePressed(_ sender: UIButton) {
        car.timesDriven += 1
        car.lastStarted = Date()
        do {
            try context.save()
            insertDataFrom(car: car)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func ratePressed(_ sender: UIButton) {
        let alertView = UIAlertController(title: "Rate it", message: "Please rate the car", preferredStyle: .alert)
        let rateAction = UIAlertAction(title: "Rate", style: .default) { action in
            if let text = alertView.textFields?.first?.text {
                self.updateRate(with: (text as NSString).doubleValue)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertView.addTextField { textField in
            textField.keyboardType = .numberPad
        }
        
        alertView.addAction(rateAction)
        alertView.addAction(cancelAction)
        
        present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
        updateSegmentedControll()
    }
    
    private func loadDataFromFile() {
        guard let path = Bundle.main.path(forResource: "data", ofType: "plist"),
              let dataArray = NSArray(contentsOfFile: path),
              let entity = NSEntityDescription.entity(forEntityName: "Car", in: context) else { return }
        
        for dictonary in dataArray {
            let carObj = Car(entity: entity, insertInto: context)
            
            let carDictonary = dictonary as! [String: AnyObject]
            carObj.mark = carDictonary["mark"] as? String
            carObj.model = carDictonary["model"] as? String
            carObj.rating = carDictonary["rating"] as! Double
            carObj.lastStarted = carDictonary["lastStarted"] as? Date
            carObj.timesDriven = carDictonary["timesDriven"] as! Int16
            carObj.myChoice = carDictonary["myChoice"] as! Bool
            
            let imageName = carDictonary["imageName"] as? String
            let image = UIImage(named: imageName!)
            carObj.imageData = image?.pngData()
            
            if let colorDict = carDictonary["tintColor"] as? [String : Float] {
                carObj.tintColor = getColor(colorDict: colorDict)
            }
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func getColor(colorDict: [String : Float]) -> UIColor {
        guard let red = colorDict["red"],
              let green = colorDict["green"],
              let blue = colorDict["blue"] else { return UIColor() }
        
        return UIColor(red: CGFloat(red / 255), green: CGFloat(green / 255), blue: CGFloat(blue / 255), alpha: 1.0)
    }
    
    private func insertDataFrom(car: Car) {
        markLabel.text = car.mark
        modelLabel.text = car.model
        carImageView.image = UIImage(data: car.imageData!)
        timeStartedLabel.text = "Last time started: \(dateFormater.string(from: car.lastStarted!))"
        ratingLabel.text = "Rating \(car.rating) / 10"
        numberOfTripsLabel.text = "Number of trips: \(car.timesDriven)"
        myChoiceImageView.isHidden = !car.myChoice
        carSegmentedControl.backgroundColor = car.tintColor as? UIColor
    }
    
    private func updateRate(with rating: Double) {
        car.rating = rating
        do {
            try context.save()
            insertDataFrom(car: car)
        } catch let error as NSError {
            let alertController = UIAlertController(title: "Wrong rate", message: "Wrong input", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            present(alertController, animated: true)
            print(error.localizedDescription)
        }
    }
    
    private func updateSegmentedControll() {
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        let mark = carSegmentedControl.titleForSegment(at: carSegmentedControl.selectedSegmentIndex)
        fetchRequest.predicate = NSPredicate(format: "mark == %@", mark!)
        
        do {
            let results = try context.fetch(fetchRequest)
            car = results.first
            insertDataFrom(car: car!)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        carSegmentedControl.selectedSegmentTintColor = .white
        
        let whiteTextAtributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let blackTextAtributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        UISegmentedControl.appearance().setTitleTextAttributes(whiteTextAtributes, for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes(blackTextAtributes, for: .selected)
    }
}

