// 
//  ContentUseCase.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


import Foundation
import PromiseKit

public protocol ContentUseCase {
    func getPopularMovies(page: Int) -> Promise<ResultContainer<[Movie]>>
    func searchMovies(query: String, page: Int) -> Promise<ResultContainer<[Movie]>>
    func getMovieDetails(movieID: Int) -> Promise<MovieDetails>
    func getSimilarMovies(movieID: Int) -> Promise<[Movie]>
    func getMovieCredits(movieID: Int) -> Promise<[Credit]>
}

final class MainContentUseCase: ContentUseCase {
    
    // MARK: - Properties
    private let contentRepository: ContentRepository
    
    // MARK: - Initializer
    init(
        contentRepository: ContentRepository
    ) {
        self.contentRepository = contentRepository
    }
    
    // MARK: - Methods
    func getPopularMovies(page: Int) -> Promise<ResultContainer<[Movie]>> {
        contentRepository.getPopularMovies(page: page)
    }
    
    func searchMovies(query: String, page: Int) -> Promise<ResultContainer<[Movie]>> {
        contentRepository.searchMovies(query: query, page: page)
    }
    
    func getMovieDetails(movieID: Int) -> Promise<MovieDetails> {
        contentRepository.getMovieDetails(movieID: movieID)
    }
    
    func getSimilarMovies(movieID: Int) -> Promise<[Movie]> {
        contentRepository.getSimilarMovies(movieID: movieID)
    }
    
    func getMovieCredits(movieID: Int) -> Promise<[Credit]> {
        contentRepository.getMovieCredits(movieID: movieID)
    }
}
