//
//  Constant.swift
//  MovieApp
//
//  Created by Ali Beyaz on 1.11.2023.
//

import Foundation

extension EndPoint {
    enum API: String {
        case BASE_URL = "https://api.themoviedb.org/3/"
        case IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w500/"
        case popular = "movie/popular"
        case language = "&language=en-US"
        case api_key_text = "?api_key="
        case api_key = "bd7847090fea4f76f5ce0c22bd1a85b8"
        case page = "&page="
    }
}

// Define the EndPoint struct to create URLs for movie data and images.
struct EndPoint {
    func urlStringForMovies(_ page: Int) -> String {
        return       "\(API.BASE_URL.rawValue)\(API.popular.rawValue)\(API.api_key_text.rawValue)\(API.api_key.rawValue)\(API.language.rawValue)\(API.page.rawValue)\(page)"
        
    }
    // Generate a URL string for fetching a movie poster image.
    func urlStringForImages(_ patch: String) -> String  {
        return "\(API.IMAGE_BASE_URL.rawValue)\(patch)"
    }
}
