//
//  NetworkManager.swift
//  Networking
//
//  Created by Edgar on 27.03.21.
//

import Foundation
import UIKit

class NetworkManager {
    
    static func getReques(url: String) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let response = response {
                print("Response is \(response) \n Data is \(data)")
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("JSON data \(json)")
                } catch {
                    print("Error \(error)")
                }
            }
        }.resume()
    }
    
    static func postRequest(url: String) {
        guard let url = URL(string: url) else { return }
        
        let userData = ["Course": "Networking", "Lesson": "GET and POST"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let response = response, let data = data else { return }
            print("Response is \(response)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("JSON data \(json)")
            } catch {
                print(error)
            }
        }.resume()
    }
    
    static func downloadImageData(url: String, completion:  @escaping (_ data: Data) -> ()) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            completion(data)
        }.resume()
    }
    
    static func fetchCourses(url: String, completion: @escaping (_ courses: [Course]) -> ()) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let courses = try decoder.decode([Course].self, from: data)
                completion(courses)
            } catch let error {
                print("Error serialization json", error)
            }
        }.resume()
    }
    
    static func uploadImage(url: String) {
        guard let url = URL(string: url) else { return }
        
        let image = UIImage(named: "Notification")!
        let httpHeaders = ["Authorization": "Client-ID <clientId>"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = httpHeaders
        request.httpBody = image.pngData()
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print("Response \(response)")
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Upload data \(json)")
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
