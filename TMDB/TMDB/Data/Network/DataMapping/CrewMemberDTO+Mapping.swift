// 
//  CrewMemberDTO+Mapping.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


// MARK: - CrewMemberDTO
struct CrewMemberDTO: Codable {
    let id: Int
    let name: String?
    let profilePath: String?
    let popularity: Double
    let department: DepartmentDTO?
    
    var profileURL: String? {
        guard let profilePath = profilePath else { return nil }
        return "\(Config.imageBaseURL)\(Config.ImageSize.Poster.original.rawValue)\(profilePath)"
    }
}

extension CrewMemberDTO {
    func toDomain() -> CrewMember {
        .init(
            id: id,
            name: name ?? "Unknown",
            profileURL: profileURL,
            popularity: popularity,
            department: (department ?? .unknown).toDomain()
        )
    }
}

extension CrewMemberDTO {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case popularity
        case department = "department"
    }
}
