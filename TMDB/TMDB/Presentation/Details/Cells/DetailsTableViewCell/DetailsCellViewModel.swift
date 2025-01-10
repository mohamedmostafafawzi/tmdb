// 
//  DetailsCellViewModel.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 10/01/2025.
//


import Foundation

public struct DetailsCellViewModel {
    
    // MARK: - Properties
    let id: Int
    let title: String
    let overview: String
    let posterURL: String?
    let backDropURL: String?
    let tagline: String
    let revenue: Double
    let releaseDate: String
    let status: String
    let isOnWatchlist: Bool

    // MARK: - Initializers
    init(fromDomain domain: MovieDetails) {
        self.id = domain.id
        self.title = domain.title
        self.overview = domain.overview
        self.posterURL = domain.posterURL
        self.backDropURL = domain.backDropURL
        self.tagline = domain.tagline
        self.revenue = domain.revenue
        self.releaseDate = domain.releaseDate
        self.status = domain.status
        self.isOnWatchlist = domain.isOnWatchlist
    }
}
