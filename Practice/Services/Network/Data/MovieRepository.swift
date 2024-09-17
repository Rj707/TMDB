//
//  MovieRepositoryImpl.swift
//  Practice
//
//  Created by iApple Basement on 13/09/2024.
//


import Foundation

// Protocol defining the repository layer that interacts with the data source
protocol MovieRepository {
    
    /// Fetch trending movies
    /// - Parameter completion: A closure that provides a result, either an array of `Movie` or an `APIError`
    func fetchTrendingMovies(completion: @escaping MoviesResult)
    
    /// Fetch image data for a movie
    /// - Parameters:
    ///   - path: The path to the image
    ///   - completion: A closure that provides a result, either `Data` (image) or an `APIError`
    func fetchMovieImage(path: String, completion: @escaping ImageResult)
}

// Concrete implementation of the MovieRepository
class DefaultMovieRepository: MovieRepository {
    
    private let dataSource: MovieDataSource
    
    /// Initializes the repository with a data source
    /// - Parameter dataSource: The data source used to fetch data (movies and images)
    init(dataSource: MovieDataSource) {
        self.dataSource = dataSource
    }
    
    /// Fetch trending movies via the API service
    /// - Parameter completion: A closure that provides a result, either an array of `Movie` or an `APIError`
    func fetchTrendingMovies(completion: @escaping MoviesResult) {
        print("DefaultMovieRepository: Initiating fetchTrendingMovies.")
        
        // Delegates the API call to the data source via APIService
        APIService.shared.callApi(call: { callback in
            print("DefaultMovieRepository: Fetching trending movies from dataSource.")
            self.dataSource.fetchTrendingMovies(completion: callback)
        }, completion: { result in
            switch result {
            case .success(let movies):
                print("DefaultMovieRepository: Successfully fetched \(movies.count) movies.")
            case .failure(let error):
                print("DefaultMovieRepository: Failed to fetch movies with error: \(error).")
            }
            completion(result) // Returning the result back to the caller
        })
    }
    
    /// Fetch movie image data via the API service
    /// - Parameters:
    ///   - path: The path to the movie image
    ///   - completion: A closure that provides a result, either `Data` (image) or an `APIError`
    func fetchMovieImage(path: String, completion: @escaping ImageResult) {
        print("DefaultMovieRepository: Initiating fetchMovieImage for path: \(path).")
        
        // Delegates the API call to the data source via APIService
        APIService.shared.callApi(call: { callback in
            print("DefaultMovieRepository: Fetching movie image from dataSource for path: \(path).")
            self.dataSource.fetchMovieImage(path: path, completion: callback)
        }, completion: { result in
            switch result {
            case .success:
                print("DefaultMovieRepository: Successfully fetched movie image for path: \(path).")
            case .failure(let error):
                print("DefaultMovieRepository: Failed to fetch movie image with error: \(error).")
            }
            completion(result) // Returning the result back to the caller
        })
    }
}




