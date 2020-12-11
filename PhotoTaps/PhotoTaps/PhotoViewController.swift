//
//  PhotoViewController.swift
//  PhotoTaps
//
//  Created by Edgar on 12.12.20.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    
    var dogImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoImageView.image = dogImage
    }

    @IBAction func shareAction(_ sender: UIButton) {
        let shareController = UIActivityViewController(activityItems: [dogImage!], applicationActivities: nil)
        shareController.completionWithItemsHandler = {_, bool, _, _ in
            if bool {
                print("Success")
            }
        }
        present(shareController, animated: true, completion: nil)
    }
}
