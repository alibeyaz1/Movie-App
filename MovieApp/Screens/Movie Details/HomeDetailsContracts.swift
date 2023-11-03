//
//  HomeDetailsContracts.swift
//  MovieApp
//
//  Created by Ali Beyaz on 3.11.2023.
//

import Foundation

protocol MovieDetailsViewModelDelegate: AnyObject {
    
    
}

protocol DetailsModelType {
    
    
}

protocol MovieDetailsModelType: DetailsModelType {
    var delegate: MovieViewModelDelegate? { get set }
    init(apiManager: APIManager)
}

