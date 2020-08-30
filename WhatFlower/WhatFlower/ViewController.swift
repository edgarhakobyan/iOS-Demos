//
//  ViewController.swift
//  WhatFlower
//
//  Created by Edgar on 8/30/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

import UIKit
import CoreML
import Vision
import SwiftyJSON
import Alamofire
import SDWebImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let imagePicker = UIImagePickerController()
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary //.camera
        imagePicker.allowsEditing = false
    }
    
    // MARK: - IBActions
    
    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[.originalImage] as? UIImage {
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Failed to convert UIImage to CIImage")
            }
            detect(image: ciImage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper methods
    
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            fatalError("Failed to load CoreML model")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            if let classification = request.results?.first as? VNClassificationObservation {
                DispatchQueue.main.async {
                    self.navigationItem.title = classification.identifier.capitalized
                }
                
                self.requestInfo(flowerName: classification.identifier)
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print("Failed to make request \(error)")
        }
    }
    
    func requestInfo(flowerName: String) {
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize": "500"
        ]
        
        AF.request(wikipediaURl, method: .get, parameters: parameters).responseJSON { (response) in
            if let safeValue = response.value {
                let resultJson = JSON(safeValue)
                let pageId = resultJson["query"]["pageids"][0].stringValue
                let flowerDescription = resultJson["query"]["pages"][pageId]["extract"].stringValue
                let flowerImageUrl = resultJson["query"]["pages"][pageId]["thumbnail"]["source"].stringValue
                
                DispatchQueue.main.async {
                    self.imageView.sd_setImage(with: URL(string: flowerImageUrl))
                    self.descriptionLabel.text = flowerDescription
                }
            }
            
        }
    }
    
}

