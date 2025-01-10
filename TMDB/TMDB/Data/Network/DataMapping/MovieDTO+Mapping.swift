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
    let title: String?
    let overview: String?
    let releaseDate: String?
    let posterPath: String?
    var posterURL: String? {
        guard let posterPath = posterPath else { return nil }
        return "\(Config.imageBaseURL)\(Config.ImageSize.Poster.original.rawValue)\(posterPath)"
    }
}

extension MovieDTO {
    func toDomain() -> Movie {
        .init(
            id: id,
            title: title ?? "Unknown Title",
            overview: overview ?? "",
            releaseYear: (releaseDate ?? "").toYear(),
            posterURL: posterURL,
            isOnWatchlist: WishlistDataStore.shared.retrieve().contains(id)
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
