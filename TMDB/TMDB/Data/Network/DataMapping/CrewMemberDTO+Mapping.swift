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
    let department: String?
    
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
            department: departmentToDomain()
        )
    }
    func departmentToDomain() -> Department {
        switch department {
        case "Acting":
            return .acting
        case "Directing":
            return .directing
        default:
            return .uknown
        }
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
