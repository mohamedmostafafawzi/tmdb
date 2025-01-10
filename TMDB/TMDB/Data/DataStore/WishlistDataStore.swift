// 
//  WishlistDataStore.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 10/01/2025.
//


import Foundation
import RxSwift

public class WishlistDataStore {
    
    // MARK: - Public Properties
    public static let shared = WishlistDataStore()
    
    // MARK: - Properties
    private let userDefaults = UserDefaults.standard
    private let key = MovieIDsManagerKey.movieIDs.rawValue
    
    // MARK: - Methods
    private init() {}
    
    /// Adds a movie ID to the saved array of movie IDs.
    public func add(movieID: Int) {
        var movieIDs = retrieve()
        if !movieIDs.contains(movieID) {
            movieIDs.append(movieID)
            save(movieIDs: movieIDs)
        }
    }
    
    /// Removes a movie ID from the saved array of movie IDs.
    public func remove(movieID: Int) {
        var movieIDs = retrieve()
        movieIDs.removeAll { $0 == movieID }
        save(movieIDs: movieIDs)
    }
    
    /// Retrieves the array of saved movie IDs.
    public func retrieve() -> [Int] {
        if let data = userDefaults.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let movieIDs = try? decoder.decode([Int].self, from: data) {
                return movieIDs
            }
        }
        // Return an empty array if retrieval fails
        return []
    }
    
    // MARK: - Private Methods
    
    /// Saves the array of movie IDs to UserDefaults.
    private func save(movieIDs: [Int]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(movieIDs) {
            userDefaults.set(encoded, forKey: key)
        }
    }
}

private enum MovieIDsManagerKey: String {
    case movieIDs = "movie-ids"
}
