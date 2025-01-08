// 
//  HTTPMethod.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 08/01/2025.
//


import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
    case patch = "PATCH"
}