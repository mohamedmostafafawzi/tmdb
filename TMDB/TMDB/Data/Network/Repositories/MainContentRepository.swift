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
    public func getPopularMovies(page: Int) -> Promise<ResultContainer<[Movie]>> {
        func getPopularMoviesResponse() -> Promise<ResultResponseContainer<[MovieDTO]>> {
            return networkService.fetchRequest(forRoute: ContentRouter.getPopularMovies(page: page))
        }
        return getPopularMoviesResponse().map {
            ResultContainer(
                results: $0.results.map { $0.toDomain() },
                totalPages: $0.totalPages
            )
        }
    }
    
    public func searchMovies(query: String, page: Int) -> Promise<ResultContainer<[Movie]>> {
        func searchMoviesResponse() -> Promise<ResultResponseContainer<[MovieDTO]>> {
            return networkService.fetchRequest(forRoute: ContentRouter.searchMovies(query: query, page: page))
        }
        return searchMoviesResponse().map {
            ResultContainer(
                results: $0.results.map { $0.toDomain() },
                totalPages: $0.totalPages
            )
        }
    }
    
    public func getMovieDetails(movieID: Int) -> Promise<MovieDetails> {
        func getMovieDetailsResponse() -> Promise<MovieDetailsDTO> {
            return networkService.fetchRequest(forRoute: ContentRouter.getMovieDetails(movieID: movieID))
        }
        return getMovieDetailsResponse().map { $0.toDomain() }
    }
    
    public func getSimilarMovies(movieID: Int, page: Int) -> Promise<ResultContainer<[Movie]>> {
        func getSimilarMoviesResponse() -> Promise<ResultResponseContainer<[MovieDTO]>> {
            return networkService.fetchRequest(forRoute: ContentRouter.getSimilarMovies(movieID: movieID, page: page))
        }
        return getSimilarMoviesResponse().map {
            ResultContainer(
                results: $0.results.map { $0.toDomain() },
                totalPages: $0.totalPages
            )
        }
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
