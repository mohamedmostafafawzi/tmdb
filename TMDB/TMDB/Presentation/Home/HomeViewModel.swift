// 
//  HomeViewModel.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//


import RxSwift
import RxCocoa

public class HomeViewModel: ViewModelType {
    
    // MARK: - Input & Output
    public var input: HomeViewModel.Input
    public var output: HomeViewModel.Output
    
    public struct Input {
        let getPopularMovies = PublishSubject<()>()
        let homeItemSelected = PublishSubject<HomeCellViewModel>()
    }
    
    public struct Output {
        let homeSections: BehaviorRelay<[HomeSectionViewModel]>
        let isLoading: Driver<Bool>
    }
        
    // MARK: - Subjects
    private let homeSectionsSubject = BehaviorRelay<[HomeSectionViewModel]>(value: [])
    private let isLoadingSubject = BehaviorSubject<Bool>(value: false)

    // MARK: - Properties
    private weak var navigationDelegate: HomeViewControllerNavigationDelegate?
    private let contentUseCase: ContentUseCase
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    public init(navigationDelegate: HomeViewControllerNavigationDelegate,
                contentUseCase: ContentUseCase) {
        
        self.navigationDelegate = navigationDelegate
        self.contentUseCase = contentUseCase
        
        // Configure input & output
        input = Input()
        output = Output(homeSections: homeSectionsSubject,
                        isLoading: isLoadingSubject.asDriver(onErrorJustReturn: false))
        
        // Subscribe for input events
        subscribeToGetPopularMovies()
        subscribeToHomeItemSelected()

    }
    
    // MARK: - Internal logic
    private func getPopularMovies() {
        isLoadingSubject.onNext(true)
        // TODO: - Pagination
        contentUseCase.getPopularMovies(page: 1)
            .done { [weak self] results in
                guard let self else { return }
                configureSections(with: results.results)
            }
            .catch(handleError)
            .finally { [weak self] in
                self?.isLoadingSubject.onNext(false)
            }
    }
    
    private func configureSections(with movies: [Movie]) {
        // Group movies by their release year
        let groupedMovies = Dictionary(grouping: movies, by: { $0.releaseYear })
        
        // Transform groups into sections
        let sections = groupedMovies.map { year, movies in
            HomeSectionViewModel(
                title: year,
                items: movies.map { HomeCellViewModel(fromDomain: $0) }
            )
        }.sorted { $0.title < $1.title }
        // TODO: - Append to it after implementing pagination
        self.homeSectionsSubject.accept(sections)
    }
    
    // MARK: - Input events subscription
    private func subscribeToGetPopularMovies() {
        input.getPopularMovies.subscribe(onNext: { [weak self] in
            self?.getPopularMovies()
        }).disposed(by: disposeBag)
    }
    
    private func subscribeToHomeItemSelected() {
        input.homeItemSelected
            .subscribe(onNext: { [weak self] item in
                // TODO: Navigate to movie details
                print("Title: \(item.title) with id: \(item.id) Selected")
            }).disposed(by: disposeBag)
    }
}

// MARK: - Error handling
extension HomeViewModel {
    private func handleError(_ error: Error) {
        // TODO: Error handling
    }
}
