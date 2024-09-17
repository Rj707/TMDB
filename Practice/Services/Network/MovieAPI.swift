//
//  MovieAPI.swift
//  Practice
//
//  Created by Hafiz Saad on 13/09/2024.
//

import Foundation

protocol MovieAPI {
    
    // Method to fetch data from an API
    func fetchTrendingMovies(callback: @escaping (Result<[Movie], APIError>) -> Void)
    // Method to fetch images from an API
    func fetchMovieImage(path: String, callback: @escaping (Result<Data, APIError>) -> Void)
}

class MovieAPIService: MovieAPI {
    
    init() {}
    
    // Fetch trending movies implementation
    func fetchTrendingMovies(callback: @escaping MoviesResult) {
        let endpoint = "trending/all/day?api_key=\(APIService.privateKey)"
        var request = URLRequest(url: URL(string: "\(APIService.baseURL?.absoluteString ?? "")\(endpoint)")!)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Perform the network call
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                callback(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                callback(.failure(.requestFailed))
                return
            }
            
            do {
                let movies = try JSONDecoder().decode(TrendingMovieModel.self, from: data)
                callback(.success(movies.results))
            } catch {
                callback(.failure(.parsingError(error)))
            }
        }
        task.resume()
    }
    
    // Fetch movie image implementation
    func fetchMovieImage(path: String, callback: @escaping ImageResult) {
        let endpoint = path
        var request = URLRequest(url: URL(string: "\(APIService.imageBaseURL?.absoluteString ?? "")\(endpoint)")!)
        request.httpMethod = HTTPMethod.get.rawValue
        // Perform the network call
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                callback(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                callback(.failure(.requestFailed))
                return
            }
            
            callback(.success(data))
        }
        task.resume()
    }
    
}
