//
//  NetworkManager.swift
//  MVVM-2
//
//  Created by Edgar on 31.01.21.
//

import Foundation

class NetworkManager: NSObject {
    
    func fetchMovies(completion: ([String]) -> ()) {
        let movies = ["Movie 1", "Movie 2", "Movie 3"]
        completion(movies)
    }
}
