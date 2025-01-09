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
    
    /// Remote Image sizes
    enum ImageSize {
        enum Profile: String {
            case w45 = "w45"
            case w185 = "w185"
            case h632 = "h632"
            case original = "original"
        }

        enum Poster: String {
            case w92 = "w92"
            case w154 = "w154"
            case w185 = "w185"
            case w342 = "w342"
            case w500 = "w500"
            case w780 = "w780"
            case original = "original"
        }

        enum Backdrop: String {
            case w300 = "w300"
            case w780 = "w780"
            case w1280 = "w1280"
            case original = "original"
        }
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
