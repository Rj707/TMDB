//
//  MovieDataSource.swift
//  Practice
//
//  Created by Hafiz Saad on 13/09/2024.
//

import Foundation

// Protocol defining the data source layer for fetching data from a backend API
protocol MovieDataSource {
    
    /// Fetch trending movies
    /// - Parameter completion: A closure that provides a result, either an array of `Movie` or an `APIError`
    func fetchTrendingMovies(completion: @escaping MoviesResult)
    
    /// Fetch image data for a movie
    /// - Parameters:
    ///   - path: The path to the image
    ///   - completion: A closure that provides a result, either `Data` (image) or an `APIError`
    func fetchMovieImage(path: String, completion: @escaping ImageResult)
}

// Concrete implementation of the MovieDataSource
class MovieDataSourceImplementation: MovieDataSource {
    
    private let movieAPIService: MovieAPIService
    
    /// Initialize the data source with the API service
    /// - Parameter movieAPIService: The service that interacts with the API for movie data
    init(movieAPIService: MovieAPIService) {
        self.movieAPIService = movieAPIService
    }
    
    /// Fetch trending movies using the API service
    /// - Parameter completion: A closure that provides a result, either an array of `Movie` or an `APIError`
    func fetchTrendingMovies(completion: @escaping MoviesResult) {
        print("MovieDataSourceImplementation: Fetching trending movies via movieAPIService.")
        
        // Pass the completion handler to the API service
        movieAPIService.fetchTrendingMovies(callback: completion)
    }
    
    /// Fetch movie image data using the API service
    /// - Parameters:
    ///   - path: The path to the movie image
    ///   - completion: A closure that provides a result, either `Data` (image) or an `APIError`
    func fetchMovieImage(path: String, completion: @escaping ImageResult) {
        print("MovieDataSourceImplementation: Fetching movie image via movieAPIService for path: \(path).")
        
        // Pass the completion handler to the API service
        movieAPIService.fetchMovieImage(path: path, callback: completion)
    }
}

