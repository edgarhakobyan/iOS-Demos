//
//  ViewController.swift
//  MealTimeCoreData
//
//  Created by Edgar on 26.02.21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var context: NSManagedObjectContext!
    var user: User!
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let userName = "Tom"
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", userName)
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                user = User(context: context)
                user.name = userName
                try context.save()
            } else {
                user = results.first
            }
        } catch let error as NSError {
            print(error)
        }
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let meal = Meal(context: context)
        meal.date = Date()
        
        let meals = user.meals?.mutableCopy() as? NSMutableSet
        meals?.add(meal)
        user.meals = meals
        
        do {
            try context.save()
            tableView.reloadData()
        } catch let error as NSError {
            print(error)
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My meal time!"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.meals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        guard let meal = user.meals?.allObjects[indexPath.row] as? Meal,
              let date = meal.date else { return cell }
        
        cell.textLabel?.text = dateFormatter.string(from: date)
        
        return cell
    }
}
