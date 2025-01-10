// 
//  Credit.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


public protocol Credit {
    var id: Int { get }
    var name: String { get }
    var profileURL: String? { get }
    var popularity: Double { get }
    var department: Department { get }
}
