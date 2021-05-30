//
//  MainViewController.swift
//  Networking
//
//  Created by Edgar on 27.03.21.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class MainViewController: UICollectionViewController {
    private let actions = Actions.allCases
    private let url = "https://jsonplaceholder.typicode.com/posts"
    private let uploadImageUrl = "https://api.imgur.com/3/image"
    private let reuseIdentifier = "Cell"
    private let dataProvider = DataProvider()
    
    private var alert: UIAlertController!
    private var filePath: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForNotifications()
        
        dataProvider.fileLocation = { (location) in
            // Save your file somewhere, or use it...
            self.filePath = location.absoluteString
            self.alert?.dismiss(animated: false)
            self.postNotification()
            
            print("Download finished: \(location.absoluteString)")
        }
        
        showFBLoginVCIfNeed()
    }
    
    private func showAlert() {
        alert = UIAlertController(title: "Downloading...", message: "0%", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            self.dataProvider.stopDownload()
        }
        
        let height = NSLayoutConstraint(item: alert.view!,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 0,
                                        constant: 170)
        alert.view.addConstraint(height)
        alert.addAction(cancelAction)
        
        present(alert, animated: true) {
            let size = CGSize(width: 40, height: 40)
            let point = CGPoint(x: self.alert.view.frame.width / 2 - size.width / 2,
                                y: self.alert.view.frame.height / 2 - size.height / 2)
            let activityIdicator = UIActivityIndicatorView(frame: CGRect(origin: point, size: size))
            activityIdicator.color = .gray
            activityIdicator.startAnimating()
            
            let progressView = UIProgressView(frame: CGRect(x: 0,
                                                            y: self.alert.view.frame.height - 44,
                                                            width: self.alert.view.frame.width,
                                                            height: 2))
            progressView.tintColor = .blue
            
            self.dataProvider.onProgress = { (progress) in
                progressView.progress = Float(progress)
                self.alert.message = String(Int(progress * 100)) + "%"
                
                if progressView.progress == 1 {
                    self.alert.dismiss(animated: false)
                }
            }
            
            self.alert.view.addSubview(activityIdicator)
            self.alert.view.addSubview(progressView)
        }
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let coursesVC = segue.destination as? CoursesTableViewController
        let imageVC = segue.destination as? ImageViewController
        
        switch segue.identifier {
        case "ShowCourseSegue":
            coursesVC?.fetchData()
        case "ShowCourseAlamofireSegue":
            coursesVC?.fetchDataWithAlamofire()
        case "PostRequest":
            coursesVC?.postRequestAlamofire()
        case "PutRequest":
            coursesVC?.putRequestAlamofire()
        case "ShowImageViewSegue":
            imageVC?.fetchImage()
        case "ShowImageViewAlamofireSegue":
            imageVC?.fetchImageWithAlamofire()
            AlamofireNetworkManager.responseData(url: url)
        case "ShowLargeImageViewSegue":
            imageVC?.fetchLargeImage()
        default:
            print("")
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.actionLabel.text = actions[indexPath.row].rawValue
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let action = actions[indexPath.row]
        
        switch action {
        case .downloadImage:
            performSegue(withIdentifier: "ShowImageViewSegue", sender: self)
        case .get:
            NetworkManager.getReques(url: url)
        case .post:
            NetworkManager.postRequest(url: url)
        case .ourCourses:
            performSegue(withIdentifier: "ShowCourseSegue", sender: self)
        case .uploadImage:
            NetworkManager.uploadImage(url: uploadImageUrl)
        case .downloadFile:
            dataProvider.startDownload()
            showAlert()
        case .ourCoursesWithAlamofire:
            performSegue(withIdentifier: "ShowCourseAlamofireSegue", sender: self)
        case .responseData:
            performSegue(withIdentifier: "ShowImageViewAlamofireSegue", sender: self)
        case .downloadLargeImage:
            performSegue(withIdentifier: "ShowLargeImageViewSegue", sender: self)
        case .postRequest:
            performSegue(withIdentifier: "PostRequest", sender: self)
        case .putRequest:
            performSegue(withIdentifier: "PutRequest", sender: self)
        case .uploadImageWithAlamofire:
            AlamofireNetworkManager.uploadImage(url: uploadImageUrl)
        }
    }
}

extension MainViewController {
    private func registerForNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (_, _) in }
    }
    
    private func postNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Download complete!"
        content.body = "Your background transfer has completed. File path: \(filePath ?? "")"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        let request = UNNotificationRequest(identifier: "TransferComplete", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}

enum Actions: String, CaseIterable {
    case downloadImage = "Download Image"
    case get = "GET"
    case post = "POST"
    case ourCourses = "Our Courses"
    case uploadImage = "Upload Image"
    case downloadFile = "Dowbload File"
    case ourCoursesWithAlamofire = "Our Courses (Alamofire)"
    case responseData = "Download Image (Alamofire)"
    case downloadLargeImage = "Download large image (Alamofire)"
    case postRequest = "POST (Alamofire)"
    case putRequest = "PUT (Alamofire)"
    case uploadImageWithAlamofire = "Upload Image (Alamofire)"
}

// MARK: Facebook SDK
extension MainViewController {
    private func isLoggedInFacebook() -> Bool {
        if let token = AccessToken.current, !token.isExpired {
            return true
        }
        return false
    }
    
    private func showFBLoginVCIfNeed() {
//        let token = AccessToken.current
//        if token == nil || token!.isExpired {
        if Auth.auth().currentUser == nil {
    //        DispatchQueue.main.async {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = sb.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
                self.present(loginVC, animated: true)
    //        }
        }
    }
}
