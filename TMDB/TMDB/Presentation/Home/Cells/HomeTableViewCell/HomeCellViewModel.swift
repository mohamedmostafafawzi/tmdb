// 
//  HomeCellViewModel.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


import Foundation

public struct HomeCellViewModel: Hashable {
    
    // MARK: - Properties
    let identifier: UUID = UUID()
    let id: Int
    let title: String
    let overview: String
    let imageURL: String?
    let releaseYear: Int
    let isOnWatchlist: Bool

    // MARK: - Initializers
    init(fromDomain domain: Movie) {
        self.id = domain.id
        self.title = domain.title
        self.overview = domain.overview
        self.imageURL = domain.posterURL
        self.releaseYear = domain.releaseYear
        self.isOnWatchlist = domain.isOnWatchlist
    }
    
    // MARK: - Methods
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    public static func == (lhs: HomeCellViewModel, rhs: HomeCellViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
