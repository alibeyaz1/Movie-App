//
//  HomeContracts.swift
//  MovieApp
//
//  Created by Ali Beyaz on 1.11.2023.
//

import Foundation

protocol MovieViewModelDelegate: AnyObject {
    func moviesLoaded()
}

protocol ViewModelType {
    func bootstrap()
    func fetchMovies()
    func fetchMovieCoreDate()
    func getMovie(at idx: Int) -> Movie
    var count: Int { get }
    
}

protocol MovieViewModelType: ViewModelType {
    var delegate: MovieViewModelDelegate? { get set }
    init(apiManager: APIManager)
}

protocol MovieListItemDelegate: AnyObject {
    func selectedMovie(movie: Movie)
}
