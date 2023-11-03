//
//  Movies.swift
//  MovieApp
//
//  Created by Ali Beyaz on 1.11.2023.
//

import Foundation

struct Movies : Codable {
    let results : [Movie]
}

struct Movie : Codable {
    let id : Int
    let title : String
    let releaseDate : String
    let overview : String
    let posterImagePath : String
    let voteAverage : Double
    let backdropPath : String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case releaseDate = "release_date"
        case overview = "overview"
        case voteAverage = "vote_average"
        case posterImagePath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
}
