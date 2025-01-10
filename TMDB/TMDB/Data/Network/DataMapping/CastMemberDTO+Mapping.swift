// 
//  CastMemberDTO+Mapping.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


// MARK: - CastMemberDTO
struct CastMemberDTO: Codable {
    let id: Int
    let name: String?
    let profilePath: String?
    let popularity: Double
    
    var profileURL: String? {
        guard let profilePath = profilePath else { return nil }
        return "\(Config.imageBaseURL)\(Config.ImageSize.Poster.original.rawValue)\(profilePath)"
    }
}

extension CastMemberDTO {
    func toDomain() -> CastMember {
        .init(
            id: id,
            name: name ?? "Unknown",
            profileURL: profileURL,
            popularity: popularity,
            department: .acting
        )
    }
}

extension CastMemberDTO {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case popularity
    }
}
