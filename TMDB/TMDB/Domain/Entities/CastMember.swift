// 
//  CastMember.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//

import Foundation

public struct CastMember: Credit {
    public let id: Int
    public let name: String
    public let profileURL: String?
    public let popularity: Double
    public let department: Department
}
