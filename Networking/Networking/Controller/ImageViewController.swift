//
//  ImageViewController.swift
//  Networking
//
//  Created by Edgar on 27.03.21.
//

import UIKit

class ImageViewController: UIViewController {
    private let url = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    private let largeImageUrl = "https://i.imgur.com/3416rvI.jpg"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
    }
    
    func fetchImage() {
        NetworkManager.downloadImageData(url: url) { (data) in
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.imageView.image = image
                }
            }
        }
    }
    
    func fetchImageWithAlamofire() {
        AlamofireNetworkManager.downloadImage(url: url) { (image) in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.imageView.image = image
            }
        }
    }
    
    func fetchLargeImage() {
        AlamofireNetworkManager.onProgress = { progress in
            self.progressView.isHidden = false
            self.progressView.progress = Float(progress)
        }
        
        AlamofireNetworkManager.completed = { completed in
            self.progressLabel.isHidden = false
            self.progressLabel.text = completed
        }
        
        AlamofireNetworkManager.downloadLargeImage(url: largeImageUrl) { (image) in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.progressView.isHidden = true
                self.progressLabel.isHidden = true
                self.imageView.image = image
            }
        }
    }
}
