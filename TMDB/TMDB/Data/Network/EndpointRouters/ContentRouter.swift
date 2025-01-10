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
            return "movie/popular"
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
        case .getPopularMovies(let page):
            return [
                "page": page
            ]
        case .searchMovies(let query, let page):
            return [
                "query": query,
                "page": page,
                "sort_by": "release_date.desc"
            ]
        case .getSimilarMovies:
            return [
                "page": "1"
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
