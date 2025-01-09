// 
//  CastMemberDTO+Mapping.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


// MARK: - CastMemberDTO
struct CastMemberDTO: Codable {
    let id: Int
    let name: String
    let profilePath: String
    let popularity: Double
}

extension CastMemberDTO {
    func toDomain() -> CastMember {
        .init(
            id: id,
            name: name,
            profileURL: Config.imageBaseURL + Config.ImageSize.Profile.original.rawValue + profilePath,
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
