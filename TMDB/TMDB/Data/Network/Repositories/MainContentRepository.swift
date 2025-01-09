//
//  MainContentRepository.swift
//  Genshin Intact
//
//  Created by Mohamed Fawzi on 11/16/23.
//

import Foundation
import PromiseKit

public final class MainContentRepository: ContentRepository {
    // MARK: - Properties
    private let networkService: NetworkService
    
    // MARK: - Initializer
    public init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Methods
    public func getPopularMovies() -> Promise<[Movie]> {
        func getPopularMoviesResponse() -> Promise<ResultResponseContainer<[MovieDTO]>> {
            return networkService.fetchRequest(forRoute: ContentRouter.getPopularMovies)
        }
        return getPopularMoviesResponse().map { $0.results.map { $0.toDomain() } }
    }
    
    public func searchMovies(query: String) -> Promise<[Movie]> {
        func searchMoviesResponse() -> Promise<ResultResponseContainer<[MovieDTO]>> {
            return networkService.fetchRequest(forRoute: ContentRouter.searchMovies(query: query))
        }
        return searchMoviesResponse().map { $0.results.map { $0.toDomain() } }
    }
    
    public func getMovieDetails(movieID: Int) -> Promise<MovieDetails> {
        func getMovieDetailsResponse() -> Promise<MovieDetailsDTO> {
            return networkService.fetchRequest(forRoute: ContentRouter.getMovieDetails(movieID: movieID))
        }
        return getMovieDetailsResponse().map { $0.toDomain() }
    }
    
    public func getSimilarMovies(movieID: Int) -> Promise<[Movie]> {
        func getSimilarMoviesResponse() -> Promise<ResultResponseContainer<[MovieDTO]>> {
            return networkService.fetchRequest(forRoute: ContentRouter.getSimilarMovies(movieID: movieID))
        }
        return getSimilarMoviesResponse().map { $0.results.map { $0.toDomain() } }
    }
    
    public func getMovieCredits(movieID: Int) -> Promise<[Credit]> {
        func getMovieCreditsResponse() -> Promise<CreditsDTO> {
            return networkService.fetchRequest(forRoute: ContentRouter.getMovieCredits(movieID: movieID))
        }
        return getMovieCreditsResponse().map { creditsDTO in
            let castMembers = creditsDTO.cast.map { $0.toDomain() }
            let crewMembers = creditsDTO.crew.map { $0.toDomain() }
            return castMembers + crewMembers
        }
    }
}
