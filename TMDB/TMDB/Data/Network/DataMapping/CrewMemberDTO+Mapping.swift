// 
//  CrewMemberDTO+Mapping.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


// MARK: - CrewMemberDTO
struct CrewMemberDTO: Codable {
    let id: Int
    let name: String
    let profilePath: String
    let popularity: Double
    let department: DepartmentDTO
}

extension CrewMemberDTO {
    func toDomain() -> CrewMember {
        .init(
            id: id,
            name: name,
            profileURL: Config.imageBaseURL + Config.ImageSize.Profile.original.rawValue + profilePath,
            popularity: popularity,
            department: department.toDomain()
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
