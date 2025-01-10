// 
//  MovieDetailsViewModel.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 10/01/2025.
//


import RxSwift
import RxCocoa

public class MovieDetailsViewModel: ViewModelType {
    
    // MARK: - Input & Output
    public var input: MovieDetailsViewModel.Input
    public var output: MovieDetailsViewModel.Output
    
    public struct Input {
        let getDetails = PublishSubject<()>()
        let searchTFText = PublishSubject<String>()
        let addToWishlistSelected = PublishSubject<Int>()
    }
    
    public struct Output {
        let movieDetails: BehaviorRelay<DetailsCellViewModel?>
        let similarMovies: BehaviorRelay<[CardCellViewModel]>
        let actors: BehaviorRelay<[CardCellViewModel]>
        let directors: BehaviorRelay<[CardCellViewModel]>
        let isLoading: Driver<Bool>
    }
        
    // MARK: - Subjects
    private let movieDetailsSubject = BehaviorRelay<DetailsCellViewModel?>(value: nil)
    private let similarMoviesSubject = BehaviorRelay<[CardCellViewModel]>(value: [])
    private let actorsSubject = BehaviorRelay<[CardCellViewModel]>(value: [])
    private let directorsSubject = BehaviorRelay<[CardCellViewModel]>(value: [])
    private let isLoadingSubject = BehaviorSubject<Bool>(value: false)

    // MARK: - Properties
    private let movieID: Int
    private weak var navigationDelegate: MovieDetailsViewControllerNavigationDelegate?
    private let contentUseCase: ContentUseCase
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    public init(movieID: Int,
                navigationDelegate: MovieDetailsViewControllerNavigationDelegate,
                contentUseCase: ContentUseCase) {
        self.movieID = movieID
        self.navigationDelegate = navigationDelegate
        self.contentUseCase = contentUseCase
        
        // Configure input & output
        input = Input()
        output = Output(movieDetails: movieDetailsSubject,
                        similarMovies: similarMoviesSubject,
                        actors: actorsSubject,
                        directors: directorsSubject,
                        isLoading: isLoadingSubject.asDriver(onErrorJustReturn: false))
        
        // Subscribe for input events
        subscribeToGetMovieDetails()
        subscribeToAddToWishlistSelected()
    }
    
    // MARK: - Internal logic
    private func getMovieDetails() {
        isLoadingSubject.onNext(true)
        contentUseCase.getMovieDetails(movieID: movieID)
            .done { [weak self] result in
                guard let self else { return }
                let details = DetailsCellViewModel(fromDomain: result)
                self.movieDetailsSubject.accept(details)
            }
            .catch(handleError)
            .finally { [weak self] in
                self?.isLoadingSubject.onNext(false)
            }
    }
    
    private func getSimilarMoviesAndCredits() {
        isLoadingSubject.onNext(true)
        
        contentUseCase.getSimilarMovies(movieID: movieID)
            .done { [weak self] result in
                guard let self else { return }
                
                let similarMovies = result.prefix(5).map { CardCellViewModel(fromDomain: $0) }
                self.similarMoviesSubject.accept(similarMovies)
                
                self.fetchCreditsForMovies(similarMovies.compactMap ({ $0.id }))
            }
            .catch(handleError)
            .finally { [weak self] in
                self?.isLoadingSubject.onNext(false)
            }
    }

    private func fetchCreditsForMovies(_ movieIDs: [Int]) {
        var credit = [Credit]()

        let group = DispatchGroup()
        
        for id in movieIDs {
            group.enter()
            isLoadingSubject.onNext(true)
            contentUseCase.getMovieCredits(movieID: id)
                .done { result in
                    credit.append(contentsOf: result)
                }
                .catch(handleError)
                .finally { [weak self] in
                    self?.isLoadingSubject.onNext(false)
                    group.leave()
                }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            let movieDirectors = credit
                .filter { $0.department == .directing }
                .prefix(5)
                .sorted { $0.popularity > $1.popularity }
                .map { CardCellViewModel(fromDomain: $0) }
            self.directorsSubject.accept(movieDirectors)

            let movieActors = credit
                .filter { $0.department == .acting }
                .prefix(5)
                .sorted { $0.popularity > $1.popularity }
                .map { CardCellViewModel(fromDomain: $0) }
            self.actorsSubject.accept(movieActors)
        }
    }

    
    // MARK: - Helper functions
    
    // MARK: - Input events subscription
    private func subscribeToGetMovieDetails() {
        input.getDetails.subscribe(onNext: { [weak self] in
            guard let self else { return }
            self.getMovieDetails()
            self.getSimilarMoviesAndCredits()
        }).disposed(by: disposeBag)
    }
    
    private func subscribeToAddToWishlistSelected() {
        input.addToWishlistSelected
            .subscribe(onNext: { [weak self] movieID in
                // TODO: Add movie to wishlist
            }).disposed(by: disposeBag)
    }
}

// MARK: - Error handling
extension MovieDetailsViewModel {
    private func handleError(_ error: Error) {
        // TODO: Error handling
    }
}
