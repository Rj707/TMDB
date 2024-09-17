
import Foundation

typealias MoviesResult = (Result<[Movie], APIError>) -> Void
typealias ImageResult = (Result<Data, APIError>) -> Void

