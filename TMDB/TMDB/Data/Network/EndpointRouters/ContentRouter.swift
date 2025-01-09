// 
//  ContentRouter.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


import Foundation

enum ContentRouter: EndpointRouter {
    case getPopularMovies
    case searchMovies(query: String)
    case getMovieDetails(movieID: Int)
    case getSimilarMovies(movieID: Int)
    case getMovieCredits(movieID: Int)
    
    
    var method: HTTPMethod {
        switch self {
        case .getPopularMovies,
             .searchMovies,
             .getMovieDetails,
             .getSimilarMovies,
             .getMovieCredits:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getPopularMovies:
            return "discover/movie"
        case .searchMovies:
            return "search/movie"
        case .getMovieDetails(let movieID):
            return "movie/\(movieID)"
        case .getSimilarMovies(let movieID):
            return "movie/\(movieID)/similar"
        case .getMovieCredits(let movieID):
            return "movie/\(movieID)/credits"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getPopularMovies:
            return nil
        case .searchMovies(let query):
            return [
                "query": query
            ]
        case .getMovieDetails(let movieID):
            return nil
        case .getSimilarMovies(let movieID):
            return nil
        case .getMovieCredits(let movieID):
            return nil
        }
    }
    
    var body: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    
}
