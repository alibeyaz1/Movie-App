//
//  CoreDataManager.swift
//  MovieApp
//
//  Created by Ali Beyaz on 2.11.2023.
//

import Foundation
import UIKit
import CoreData

struct CoreDataManager{
    
    private static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Function to save an array of Movie objects to Core Data
    public static func saveContext(movies: [Movie]){
        var cachedMovies:[DataMovie] = []
        for movie in movies{
            cachedMovies.append(encodeMovie(movie))
        }
        saveContext()
    }
    
    // Function to fetch and convert cached movies from Core Data to Movies object
    public static func fetchPopulerMovies() -> Movies{
        let movieListRequest: NSFetchRequest<DataMovie> = DataMovie.fetchRequest()
        do{
            let cachedMovieList = try context.fetch(movieListRequest)
            var movieList:[Movie] = []
            for movie in cachedMovieList{
                movieList.append(decodeCacheMovies(movie))
            }
            
            let movies = Movies(results: movieList)
            return movies
        }
        catch{
            print(error.localizedDescription)
            return Movies(results: [])
        }
    }
    // Function to delete all cached movies from Core Data
    public static func deleteAllMovies() {
        let movieListRequest: NSFetchRequest<DataMovie> = DataMovie.fetchRequest()
        
        do {
            let cachedMovieList = try context.fetch(movieListRequest)
            for movie in cachedMovieList {
                context.delete(movie)
            }
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    private static func encodeMovie(_ movie:Movie)->DataMovie{
        let dataMovie = DataMovie.init(context: context)
        dataMovie.posterImagePath = movie.posterImagePath
        dataMovie.voteAverage = movie.voteAverage
        dataMovie.releaseDate = movie.releaseDate
        dataMovie.title = movie.title
        dataMovie.id = Int64(movie.id)
        dataMovie.overview = movie.overview
        dataMovie.backdropPath = movie.backdropPath
        return dataMovie
    }
    
    private static func decodeCacheMovies(_ dataMovie: DataMovie) -> Movie{
        let movie = Movie(id: Int(dataMovie.id),
                          title: dataMovie.title ?? "",
                          releaseDate: dataMovie.releaseDate ?? "",
                          overview: dataMovie.overview ?? "" ,
                          posterImagePath: dataMovie.posterImagePath ?? "",
                          voteAverage: dataMovie.voteAverage,
                          backdropPath: dataMovie.backdropPath ?? "")
        return movie
    }
    
    // Helper function to save changes to the Core Data context
    private static func saveContext(){
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
}
