// 
//  MovieDTO+Mapping.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//

import Foundation

// MARK: - MovieDTO
struct MovieDTO: Codable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String
}

extension MovieDTO {
    func toDomain() -> Movie {
        .init(
            id: id,
            title: title,
            overview: overview,
            releaseYear: releaseDate.toYear(),
            posterURL: Config.imageBaseURL + Config.ImageSize.Poster.original.rawValue + posterPath,
            isOnWatchlist: false //TODO: - Check saved movieIDs
        )
    }
}

extension MovieDTO {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}
