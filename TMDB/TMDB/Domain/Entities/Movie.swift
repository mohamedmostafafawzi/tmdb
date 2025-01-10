// 
//  Movie.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//

import Foundation

public struct Movie {
    public let id: Int
    public let title: String
    public let overview: String
    public let releaseYear: Int
    public let posterURL: String?
    public let isOnWatchlist: Bool
}
