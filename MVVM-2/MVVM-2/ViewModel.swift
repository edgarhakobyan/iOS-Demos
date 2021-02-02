//
//  ViewModel.swift
//  MVVM-2
//
//  Created by Edgar on 31.01.21.
//

import Foundation

class ViewModel: NSObject {
    @IBOutlet weak var networkManager: NetworkManager!
    
    private var movies: [String]?
    
    func fetchMovies(completion: @escaping () -> ()) {
        networkManager.fetchMovies { [weak self] movies in
            self?.movies = movies
            completion()
        }
    }
    
    func getMoviesCount() -> Int {
        return self.movies?.count ?? 0
    }
    
    func getMovieName(byIndexPath indexPath: IndexPath) -> String {
        guard let movies = movies else { return "" }
        return movies[indexPath.row]
    }
}
