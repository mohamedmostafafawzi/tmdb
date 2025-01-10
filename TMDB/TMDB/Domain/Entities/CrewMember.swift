// 
//  CrewMember.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


public struct CrewMember: Credit {
    public let id: Int
    public let name: String
    public let profileURL: String?
    public let popularity: Double
    public let department: Department
}
