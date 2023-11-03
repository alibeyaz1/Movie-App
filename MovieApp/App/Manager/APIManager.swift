//
//  APIManager.swift
//  MovieApp
//
//  Created by Ali Beyaz on 1.11.2023.
//

import UIKit
import Alamofire
import Reachability

protocol APIManagerProtocol {
    
    func fetchMovies(byPage page: Int, completion: @escaping (Result<Movies, Error>) -> Void)
    func loadImage(_ url: String, _ completion: @escaping(Result<UIImage,Error>) -> Void )
}

class APIManager: APIManagerProtocol {
    
    var reachability : Reachability?
    
    private var movieImages = [String: UIImage]()
    
    // Load an image from a given URL.
    func loadImage(_ path: String, _ completion: @escaping(Result<UIImage,Error>) -> Void ) {
        let urlString = endPoint.urlStringForImages(path)
        
        if let image = movieImages[urlString] {
            completion(.success(image))
        }
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil
        AF.session.configuration.requestCachePolicy = .reloadIgnoringCacheData
        AF.request( urlString, method: .get).response{ response in
            switch response.result {
            case .success(let data):
                if let data = data, let image = UIImage(data: data) {
                    self.movieImages[urlString] = image
                    completion(.success(image))
                    return
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private var endPoint = EndPoint()
    
    // Fetch a list of movies by page number.
    func fetchMovies(byPage page: Int, completion: @escaping (Result<Movies, Error>) -> Void) {
        let url = endPoint.urlStringForMovies(page)
        executeRequest(url: url, onSuccess: completion)
    }
    
    //If there is an internet connection, current data is retrieved from the API. If there is no internet, the last data saved in CoreData is shown.
    private func executeRequest(url: String, onSuccess: @escaping (Result<Movies, Error>) -> Void)  {
        do {
            self.reachability = try Reachability()
        }
        catch{
            print(error)
        }
        if reachability?.connection == .unavailable{
            
            onSuccess(.success(CoreDataManager.fetchPopulerMovies()))
        }
        
        else{
            AF.request(url)
                .validate()
                .responseDecodable(of: Movies.self, queue: .main, decoder: JSONDecoder()) { (response) in
                    
                    switch response.result {
                    case .success(let data):
                        onSuccess(.success(data))
                    case .failure(let error):
                        onSuccess(.failure(error))
                        
                    }
                }
            
        }
        
        
    }
    
}
