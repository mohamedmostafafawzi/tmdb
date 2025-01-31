// 
//  ResultResponseContainer.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


import Foundation

struct ResultResponseContainer<Item: Codable>: Codable {
    
    // MARK: - Properties
    let results: Item
    let totalPages: Int
}


extension ResultResponseContainer {
    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
        
    }
}


