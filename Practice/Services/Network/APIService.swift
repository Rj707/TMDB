import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case parsingError(Error)
}

// Define HTTPMethod enum
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}

// Singleton service that handles generic API calls
class APIService {
    
    static let shared = APIService()
    
    // Base URLs
    static var baseURL = URL(string: "https://api.themoviedb.org/3/")
    static var imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w500")
    static var privateKey = "c24cfa8114ee6a92350c273b1e3214f9"
    
    private init() { } // Prevent external initialization
    
    /// Handles a generic API call
    /// - Parameters:
    ///   - call: Closure that performs the actual API request
    ///   - completion: A closure that provides a result (either success or failure)
    func callApi<T: Decodable>(
        call: @escaping (@escaping (Result<T, APIError>) -> Void) -> Void,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        print("APIService: Starting API call.")
        
        // Invoke the API call and handle the result
        call { result in
            switch result {
            case .success(let data):
                print("APIService: API call succeeded.")
                completion(.success(data))  // Pass success result to the caller
            case .failure(let error):
                print("APIService: API call failed with error: \(error).")
                completion(.failure(error)) // Pass failure result to the caller
            }
        }
    }
}


