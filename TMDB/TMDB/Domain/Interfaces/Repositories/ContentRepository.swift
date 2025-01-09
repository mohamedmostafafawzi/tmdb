// 
//  ContentRepository.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


import Foundation
import PromiseKit

protocol ContentRepository {
    func getPopularMovies() -> Promise<[Movie]>
    func searchMovies(query: String) -> Promise<[Movie]>
    func getMovieDetails(movieID: Int) -> Promise<MovieDetails>
    func getSimilarMovies(movieID: Int) -> Promise<[Movie]>
    func getMovieCredits(movieID: Int) -> Promise<[Credit]>
}
