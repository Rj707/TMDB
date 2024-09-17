import Foundation

class MovieViewModel {
    
    var movies: Observable<[Movie]> = Observable([])
    private let movieRepository: MovieRepository
    
    // Initialize with dependency injection
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func getMoviesDataFromAPI() {
        movieRepository.fetchTrendingMovies { result in
            switch result {
            case .success(let movies):
                self.movies.value = movies
                print("Fetched movies: \(movies)")
            case .failure(let error):
                print("Error fetching movies: \(error)")
            }
        }
    }
    
    func downloadImageFromAPI(endpoint: String, completionHandler: @escaping ImageResult) {
        movieRepository.fetchMovieImage(path: endpoint) { result in
            switch result {
            case .success(let imageData):
                completionHandler(.success(imageData))
                print("Fetched image data: \(imageData.count) bytes")
            case .failure(let error):
                completionHandler(.failure(error))
                print("Error fetching image: \(error)")
            }
        }
    }
}
