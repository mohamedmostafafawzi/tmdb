// 
//  TMDBError.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 08/01/2025.
//


import Foundation

public enum TMDBError: Error {
    
    // MARK: Internal
    case unknown
    case noInternet
    case decodingIssue
    case invalidEndPoint
    
    // MARK: API
    case badAPIRequest
    case notFound
    
}
