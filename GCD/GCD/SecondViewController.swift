//
//  SecondViewController.swift
//  GCD
//
//  Created by Edgar on 16.02.21.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadImage()
        delay(3) {
            self.loginAlert()
        }
    }
    
    private func loadImage() {
        let imageUrl = URL(string: "https://www.soccerpro.com/wp-content/uploads/sc3500_610_nike_barca_20_years_prestige_ball_01.jpg")
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = imageUrl, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
    
    private func loginAlert() {
        let alert = UIAlertController(title: "Register", message: "Enter login and password", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        alert.addTextField { (user) in
            user.placeholder = "Enter your login"
        }
        alert.addTextField { (password) in
            password.placeholder = "Enter your password"
            password.isSecureTextEntry = true
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
}
