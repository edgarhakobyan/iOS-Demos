//
//  CommentNetworkService.swift
//  MVC-N
//
//  Created by Edgar on 19.01.21.
//

import Foundation

class CommentNetworkService {
    private init() {}
    
    static func getComments(completion: @escaping (CommentResponse) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1/comments") else { return }
        
        NetworkService.shared.getData(url: url) { (json) in
            do {
                let response = try CommentResponse(json: json)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print("CommentNetworkService error \(error)")
            }
        }
    }
}
