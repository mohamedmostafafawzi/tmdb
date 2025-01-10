// 
//  ContentRouter.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


import Foundation

enum ContentRouter: EndpointRouter {
    case getPopularMovies(page: Int)
    case searchMovies(query: String, page: Int)
    case getMovieDetails(movieID: Int)
    case getSimilarMovies(movieID: Int, page: Int)
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
            return "movie/popular"
        case .searchMovies:
            return "search/movie"
        case .getMovieDetails(let movieID):
            return "movie/\(movieID)"
        case .getSimilarMovies(let movieID, _):
            return "movie/\(movieID)/similar"
        case .getMovieCredits(let movieID):
            return "movie/\(movieID)/credits"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getPopularMovies(let page):
            return [
                "page": page
            ]
        case .searchMovies(let query, let page):
            return [
                "query": query,
                "page": page
            ]
        case .getSimilarMovies( _, let page):
            return [
                "page": page
            ]
        default:
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
