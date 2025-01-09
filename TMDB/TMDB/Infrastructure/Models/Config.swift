// 
//  Config.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 08/01/2025.
//


import Foundation

struct Config {
    
    /// Base URL for API calls
    static var baseURL: String {
        guard let url = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            fatalError("Couldn't load base URL from info.plist")
        }
        return url
    }
    
    /// Base URL for API calls
    static var imageBaseURL: String {
        guard let url = Bundle.main.infoDictionary?["IMG_BASE_URL"] as? String else {
            fatalError("Couldn't load image base URL from info.plist")
        }
        return url
    }
    
    /// Base URL for API calls
    static var accessToken: String {
        guard let url = Bundle.main.infoDictionary?["ACCESS_TOKEN"] as? String else {
            fatalError("Couldn't load aceess token from info.plist")
        }
        return url
    }
    
    /// Base URL for API calls
    static var apiKey: String {
        guard let url = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            fatalError("Couldn't load api key from info.plist")
        }
        return url
    }
    
    /// HTTP Header keys
    enum HTTPHeaderFieldKey: String {
        case authorization = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
        case acceptLanguage = "Accept-Language"
        case country = "local-country"
        case deviceUniqueID = "device-unique-id"
        case appType = "app-type"
        case appVersion = "app-version"
    }
    
    /// HTTP Header values
    enum HTTPHeaderFieldValue: String {
        case json = "application/json"
        case ios = "ios"
    }

}
