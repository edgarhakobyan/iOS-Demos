//
//  AlamofireNetworkManager.swift
//  Networking
//
//  Created by Edgar on 30.03.21.
//

import Foundation
import Alamofire

class AlamofireNetworkManager {
    static var onProgress: ((Double) -> ())?
    static var completed: ((String) -> ())?
    
    static func sendRequest(url: String, completion: @escaping (_ courses: [Course]) -> ()) {
        guard let url = URL(string: url) else { return }
        AF.request(url, method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let courses = Course.getArray(from: value)
                print("Success: \(courses)")
                completion(courses)
            case .failure(let value):
                print("Error: \(value)")
            }
        }
    }
    
    static func downloadImage(url: String, completion: @escaping (_ image: UIImage) -> () ) {
        guard let url = URL(string: url) else { return }
        AF.request(url).responseData { (responseData) in
            switch responseData.result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                completion(image)
            case .failure(let error):
                print("Error with Alamofire \(error)")
            }
        }
    }
    
    static func downloadLargeImage(url: String, completion: @escaping (_ image: UIImage) -> ()) {
        guard let url = URL(string: url) else { return }
        AF.request(url).validate().downloadProgress { (progress) in
            print("=====================")
            print("totalUnitCount: \(progress.totalUnitCount)")
            print("completedUnitCount: \(progress.completedUnitCount)")
            print("fractionCompleted: \(progress.fractionCompleted)")
            print("localizedDescription: \(String(describing: progress.localizedDescription))")
            print("localizedAdditionalDescription: \(String(describing: progress.localizedAdditionalDescription))")
            
            self.onProgress?(progress.fractionCompleted)
            self.completed?(progress.localizedDescription)
        }.responseData { (responseData) in
            switch responseData.result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                completion(image)
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    static func responseData(url: String) {
        guard let url = URL(string: url) else { return }
        AF.request(url).responseData { (responseData) in
            switch responseData.result {
            case .success(let data):
                guard let str = String(data: data, encoding: .utf8) else { return }
                print(str)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func postRequest(url: String, completion: @escaping (_ courses: [Course]) -> ()) {
        guard let url = URL(string: url) else { return }
        let userData: [String: Any] = [
            "name": "Network Requests",
            "link": "https://swiftbook.ru/contents/our-first-applications/",
            "imageUrl": "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png",
            "numberOfLessons": 18,
            "numberOfTests": 10
        ]
        
        AF.request(url, method: .post, parameters: userData).validate().responseJSON { (responseJson) in
            guard let statusCode = responseJson.response?.statusCode else { return }
            print("Status code: \(statusCode)")
            
            switch responseJson.result {
            case .success(let value):
                guard let jsonData = value as? [String: Any] else { return }
                let course = Course(json: jsonData)
                var courses = [Course]()
                courses.append(course)
                completion(courses)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func putRequest(url: String, completion: @escaping (_ courses: [Course]) -> ()) {
        guard let url = URL(string: url) else { return }
        let userData: [String: Any] = [
            "name": "Network Requests",
            "link": "https://swiftbook.ru/contents/our-first-applications/",
            "imageUrl": "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png",
            "numberOfLessons": 18,
            "numberOfTests": 10
        ]
        
        AF.request(url, method: .put, parameters: userData).validate().responseJSON { (responseJson) in
            guard let statusCode = responseJson.response?.statusCode else { return }
            print("Status code: \(statusCode)")
            
            switch responseJson.result {
            case .success(let value):
                guard let jsonData = value as? [String: Any] else { return }
                let course = Course(json: jsonData)
                var courses = [Course]()
                courses.append(course)
                completion(courses)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func uploadImage(url: String) {
        guard let url = URL(string: url),
              let image = UIImage(named: "Notification"),
              let data = image.pngData() else { return }
        
        let httpHeaders = ["Authorization": "Client-ID <clientId>"]
        
        let uploadRequest = AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(data, withName: "image")
        }, to: url, headers: HTTPHeaders(httpHeaders))
            
        print(uploadRequest)
        
        uploadRequest.validate().responseJSON { (responseJson) in
            switch responseJson.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
