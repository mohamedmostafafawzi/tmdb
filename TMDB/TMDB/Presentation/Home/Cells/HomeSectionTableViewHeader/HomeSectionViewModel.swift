// 
//  HomeSectionViewModel.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


import Foundation

struct HomeSectionViewModel: Hashable {
    // MARK: - Properties
    let id: UUID = UUID()
    let title: String
    let items: [HomeCellViewModel]
    
    // MARK: - Methods
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: HomeSectionViewModel, rhs: HomeSectionViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
