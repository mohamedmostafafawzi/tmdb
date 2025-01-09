// 
//  MovieDetailsDTO+Mapping.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


// MARK: - MovieDetailsDTO
struct MovieDetailsDTO: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let backdropPath: String
    let tagline: String
    let revenue: Double
    let releaseDate: String
    let status: String
}

extension MovieDetailsDTO {
    func toDomain() -> MovieDetails {
        .init(
            id: id,
            title: title,
            overview: overview,
            posterURL: Config.imageBaseURL + Config.ImageSize.Poster.original.rawValue + posterPath,
            backDropURL: Config.imageBaseURL + Config.ImageSize.Backdrop.original.rawValue + backdropPath,
            tagline: tagline,
            revenue: revenue,
            releaseDate: releaseDate.toFormattedDate(),
            status: status,
            isOnWatchlist: false // TODO: - Check saved movieIDs
        )
    }
}

extension MovieDetailsDTO {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case tagline
        case revenue
        case releaseDate = "release_date"
        case status
    }
}
