// 
//  CardCellViewModel.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 10/01/2025.
//


import Foundation

public struct CardCellViewModel {
    // MARK: - Properties
    public var id: Int
    public var name: String
    public var imageURL: String?

    // MARK: - Initializers
    init(fromDomain domain: Credit) {
        self.id = domain.id
        self.name = domain.name
        self.imageURL = domain.profileURL
    }
    
    init(fromDomain domain: Movie) {
        self.id = domain.id
        self.name = domain.title
        self.imageURL = domain.posterURL
    }
}
