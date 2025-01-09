// 
//  CastMember.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//

import Foundation

public struct CastMember {
    let id: Int
    let name: String
    let profileURL: String
    let department: Department
}

public enum Department {
    case acting
    case directing
}
