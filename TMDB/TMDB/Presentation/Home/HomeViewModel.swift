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
        let searchTFText = PublishSubject<String>()
        let getPopularMovies = PublishSubject<()>()
        let homeItemSelected = PublishSubject<HomeCellViewModel>()
        let paginate = PublishSubject<()>()
    }
    
    public struct Output {
        let homeSections: BehaviorRelay<[HomeSectionViewModel]>
        let isLoading: Driver<Bool>
        let paginationManager: PaginationManager
    }
        
    // MARK: - Subjects
    private let homeSectionsSubject = BehaviorRelay<[HomeSectionViewModel]>(value: [])
    private let isLoadingSubject = BehaviorSubject<Bool>(value: false)

    // MARK: - Properties
    private weak var navigationDelegate: HomeViewControllerNavigationDelegate?
    private let contentUseCase: ContentUseCase
    private let paginationManager = PaginationManager()
    private var popularMovies: [Movie] = []
    private var moviesByYear: [Int: [Movie]] = [:]  // Movies grouped by year
    private var years: [Int] = []                   // Sorted years
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    public init(navigationDelegate: HomeViewControllerNavigationDelegate,
                contentUseCase: ContentUseCase) {
        
        self.navigationDelegate = navigationDelegate
        self.contentUseCase = contentUseCase
        
        // Configure input & output
        input = Input()
        output = Output(homeSections: homeSectionsSubject,
                        isLoading: isLoadingSubject.asDriver(onErrorJustReturn: false),
                        paginationManager: paginationManager)
        
        // Subscribe for input events
        subscribeToGetPopularMovies()
        subscribeToHomeItemSelected()
        subscribeToPaginate()
        subscribeToSearchTFText()
    }
    
    // MARK: - Internal logic
    private func getPopularMovies() {
        isLoadingSubject.onNext(true)
        contentUseCase.getPopularMovies(page: paginationManager.pageNumber.value)
            .done { [weak self] results in
                guard let self else { return }
                if popularMovies.isEmpty {
                    popularMovies = results.results
                } else {
                    popularMovies.append(contentsOf: results.results)
                }
                
                let popularSection = HomeSectionViewModel(title:"Popular Movies" ,
                                                          items: popularMovies.map { HomeCellViewModel(fromDomain: $0) })
                self.homeSectionsSubject.accept([popularSection])
                self.paginationManager.totalPages.accept(results.totalPages)
            }
            .catch(handleError)
            .finally { [weak self] in
                self?.isLoadingSubject.onNext(false)
                self?.paginationManager.isPaginating.accept(false)
            }
    }
    
    private func searchMovies(query: String) {
        isLoadingSubject.onNext(true)
        contentUseCase.searchMovies(query: query, page: paginationManager.pageNumber.value)
            .done { [weak self] results in
                guard let self else { return }
                processMovies(results.results)
                self.paginationManager.totalPages.accept(results.totalPages)
            }
            .catch(handleError)
            .finally { [weak self] in
                self?.isLoadingSubject.onNext(false)
                self?.paginationManager.isPaginating.accept(false)
            }
    }
    
    // MARK: - Helper functions
    private func processMovies(_ newMovies: [Movie]) {
        for movie in newMovies {
            let year = movie.releaseYear

            // Add to the dictionary
            if moviesByYear[year] == nil {
                moviesByYear[year] = []
                years.append(year)
                // Keep years sorted in descending order
                years.sort(by: >)
            }

            moviesByYear[year]?.append(movie)
        }

        // Update sections
        updateSections()
    }
    
    private func updateSections() {
        var sections: [HomeSectionViewModel] = []

        // Iterate over sorted years
        for year in years {
            if let movies = moviesByYear[year] {
                let section = HomeSectionViewModel(
                    title: String(year),
                    items: movies.map { HomeCellViewModel(fromDomain: $0) }
                )
                sections.append(section)
            }
        }

        // Update the relay with the new sections
        homeSectionsSubject.accept(sections)
    }
    
    private func resetSections() {
        moviesByYear = [:]
        years = []
        popularMovies = []
    }
    
    // MARK: - Input events subscription
    private func subscribeToSearchTFText() {
        input.searchTFText
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .skip(1)
            .subscribe(onNext: { [weak self] keyword in
                self?.homeSectionsSubject.accept([])
                self?.resetSections()
                self?.paginationManager.resetPagination.onNext(())
                if !keyword.isEmpty {
                    self?.searchMovies(query: keyword)
                } else {
                    self?.getPopularMovies()
                }
        }).disposed(by: disposeBag)
    }
    
    private func subscribeToGetPopularMovies() {
        input.getPopularMovies.subscribe(onNext: { [weak self] in
            self?.getPopularMovies()
        }).disposed(by: disposeBag)
    }
    
    private func subscribeToHomeItemSelected() {
        input.homeItemSelected
            .subscribe(onNext: { [weak self] item in
                guard let self else { return }
                self.navigationDelegate?.viewDetails(of: item.id)
            }).disposed(by: disposeBag)
    }
    
    private func subscribeToPaginate() {
        input.paginate
            .withLatestFrom(input.searchTFText)
            .subscribe(onNext: { [weak self] keyword in
                if !keyword.isEmpty {
                    self?.searchMovies(query: keyword)
                } else {
                    self?.getPopularMovies()
                }
            }).disposed(by: disposeBag)
    }
}

// MARK: - Error handling
extension HomeViewModel {
    private func handleError(_ error: Error) {
        // TODO: Error handling
    }
}
