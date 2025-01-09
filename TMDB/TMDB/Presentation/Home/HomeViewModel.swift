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
    }
    
    public struct Output {
        let isLoading: Driver<Bool>
    }
        
    // MARK: - Subjects
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
        output = Output(isLoading: isLoadingSubject.asDriver(onErrorJustReturn: false))
        
        // Subscribe for input events
        subscribeToGetPopularMovies()

    }
    
    // MARK: - Internal logic
    private func getPopularMovies() {
        isLoadingSubject.onNext(true)
        _ = contentUseCase.getPopularMovies(page: 1)
            .done { [weak self] in
                print("\($0.results.count) of \($0.totalPages)")
                self?.isLoadingSubject.onNext(false)
            }
    }
    
    // MARK: - Input events subscription
    private func subscribeToGetPopularMovies() {
        input.getPopularMovies.subscribe(onNext: { [weak self] in
            self?.getPopularMovies()
        }).disposed(by: disposeBag)
    }
}
