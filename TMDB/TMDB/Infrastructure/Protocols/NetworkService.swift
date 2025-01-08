// 
//  NetworkService.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 08/01/2025.
//


import Foundation
import PromiseKit

public protocol NetworkService {
    func fetchRequest<T: Decodable>(forRoute route: EndpointRouter) -> Promise<T>
}