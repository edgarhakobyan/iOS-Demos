//
//  ViewController.swift
//  SeeFood
//
//  Created by Edgar on 8/30/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary //.camera
        imagePicker.allowsEditing = false
    }

    // MARK: - IBAction
    
    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[.originalImage] as? UIImage {
            imageView.image = userPickedImage
            
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Failed to convert UIImage to CIImage")
            }
            detect(image: ciImage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper methods
    
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Failed to load CoreML model")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation], let topResult = results.first else {
                fatalError("Failed to process image")
            }
            var title = "Not Cliff!"
            var barColor = UIColor.red
            if topResult.identifier.contains("cliff") {
                title = "Cliff!"
                barColor = UIColor.green
            }
            DispatchQueue.main.async {
                self.navigationItem.title = title
                self.navigationController?.navigationBar.barTintColor = barColor
                self.navigationController?.navigationBar.tintColor = UIColor.white
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print("Failed to handle request \(error)")
        }
    }
    
}

