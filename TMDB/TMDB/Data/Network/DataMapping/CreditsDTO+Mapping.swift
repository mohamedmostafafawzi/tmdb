// 
//  CreditsDTO+Mapping.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


// MARK: - CreditsDTO
struct CreditsDTO: Codable {
    let cast: [CastMemberDTO]
    let crew: [CrewMemberDTO]
}
