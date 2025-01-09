// 
//  DepartmentDTO+Mapping.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


// MARK: - DepartmentDTO
enum DepartmentDTO: String, Codable {
    case acting
    case directing
}

extension DepartmentDTO {
    func toDomain() -> Department {
        switch self {
        case .acting: return .acting
        case .directing: return .directing
        }
    }
}
