//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Ali Beyaz on 1.11.2023.
//

import UIKit

class HomeViewModel: MovieViewModelType {
    
    // MARK: - Properties
    
    var delegate: MovieViewModelDelegate?
    private let apiManager: APIManager
    var run : Bool = false
    required init(apiManager: APIManager){
        self.apiManager = apiManager
        bootstrap()
    }
    
    private var limit: Int = 100
    private var currentPage = 0
    
    var movies = [Movie](){
        didSet {
            if self.count <= limit {
                delegate?.moviesLoaded()
            }
        }
    }
    
    func bootstrap() {
        fetchMovies()
    }
    
    func fetchMovieCoreDate(){
        self.movies = CoreDataManager.fetchPopulerMovies().results
    }
    func getMovie(at idx: Int) -> Movie {
        return movies[idx]
    }
    
    var count: Int {
        return movies.count
    }
    
    func loadImage (path: String, completion: @escaping (UIImage?) -> Void) {
        apiManager.loadImage (path) { (result) in
            switch result {
            case .success (let image):
                completion (image)
            case .failure(let error):
                print("Error: \(error)")
                completion(nil)
            }
        }
    }
    //Data is retrieved from the API by making requests for as many movies as we want in the list. When enough data comes from the API, it saves it to CoreData.
    func fetchMovies() {
        if currentPage < 5 {
            currentPage += 1
            self.apiManager.fetchMovies(byPage: currentPage) { (result) in
                switch result {
                case .success(let movie):
                    self.movies.append(contentsOf: movie.results)
                case .failure(let error):
                    print("Error: \(error)")
                }}}
        
        else if movies.count >= 100 && run == false{
            CoreDataManager.saveContext(movies: self.movies)
            run = true
            
        }
    }
}

