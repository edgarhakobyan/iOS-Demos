//
//  NetworkService.swift
//  MVC-N
//
//  Created by Edgar on 19.01.21.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    public func getData(url: URL, completion: @escaping (Any) -> ()){
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                DispatchQueue.main.async {
                    completion(json)
                }
            } catch {
                print("NetworkService error \(error)")
            }
        }.resume()
    }
}
