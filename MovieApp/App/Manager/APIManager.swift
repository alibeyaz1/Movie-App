//
//  APIManager.swift
//  MovieApp
//
//  Created by Ali Beyaz on 1.11.2023.
//

import UIKit
import Alamofire


protocol APIManagerProtocol {
    
    func fetchMovies(byPage page: Int, completion: @escaping (Result<Movies, Error>) -> Void)
    func loadImage(_ url: String, _ completion: @escaping(Result<UIImage,Error>) -> Void ) -> Void
}

class APIManager: APIManagerProtocol {
    
    private var movieImages = [String: UIImage]()
    
    func loadImage(_ path: String, _ completion: @escaping(Result<UIImage,Error>) -> Void ) -> Void {
        let urlString = endPoint.urlStringForImages(path)
        
        if let image = movieImages[urlString] {
            completion(.success(image))
        }
        
        AF.request( urlString, method: .get).response{ response in
            switch response.result {
            case .success(let data):
                if let data = data, let image = UIImage(data: data) {
                    self.movieImages[urlString] = image
                    completion(.success(image))
                    return
                }
            case .failure(let error):
                guard (error as NSError).code == NSURLErrorCancelled else {
                    completion(.failure(error.localizedDescription as! Error))
                    return
                }
            }
        }
    }
    
    private var endPoint = EndPoint()
    
    func fetchMovies(byPage page: Int, completion: @escaping (Result<Movies, Error>) -> Void) {
        let url = endPoint.urlStringForMovies(page)
        executeRequest(url: url, onSuccess: completion)
    }
    
    
    private func executeRequest(url: String, onSuccess: @escaping (Result<Movies, Error>) -> Void)  {
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
        
    }}
