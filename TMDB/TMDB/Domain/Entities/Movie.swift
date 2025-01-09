// 
//  Movie.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//

import Foundation

public struct Movie {
    let id: Int
    let title: String
    let overview: String
    let releaseYear: String
    let posterURL: String
}

public struct MovieDetails {
    let id: Int
    let title: String
    let overview: String
    let posterURL: String
    let backDropURL: String
    let tagline: String
    let revenue: Double
    let releaseDate: Date
    let status: String
    let isOnWatchlist: Bool
    
}
