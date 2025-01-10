// 
//  HomeDependencyContainer.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//

import UIKit

class HomeDependencyContainer: DependencyContainer {
    
    // MARK: - Properties
    private weak var coordinator: HomeCoordinator!
    private weak var homeCoordinatorNavigationDelegate: HomeCoordinatorNavigationDelegate!
    private let presenter: UIViewController
    private let sharedContentRepository: ContentRepository
    
    // MARK: - Initializer
    init(
        presenter: UIViewController,
        homeCoordinatorNavigationDelegate: HomeCoordinatorNavigationDelegate,
        contentRepository: ContentRepository
    ) {
        self.presenter = presenter
        self.homeCoordinatorNavigationDelegate = homeCoordinatorNavigationDelegate
        self.sharedContentRepository = contentRepository
    }
    
    // MARK: - Methods
    func makeAndStoreCoordinator() -> HomeCoordinator {
        let coordinator = HomeCoordinator(
            presenter: presenter,
            navigationDelegate: homeCoordinatorNavigationDelegate,
            homeViewControllerFactory: self,
            movieDetailsViewControllerFactory: self
        )
        self.coordinator = coordinator
        return coordinator
    }
}

// MARK: - Factories
extension HomeDependencyContainer: HomeViewControllerFactory {
    func makeHomeViewController() -> HomeViewController {
        return HomeViewController(
            viewModel: makeHomeViewModel(),
            navigationDelegate: coordinator
        )
    }
    
    private func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(
            navigationDelegate: coordinator,
            contentUseCase: MainContentUseCase(contentRepository: sharedContentRepository)
        )
    }
}

extension HomeDependencyContainer: MovieDetailsViewControllerFactory {
    func makeMovieDetailsViewController(with movieID: Int) -> MovieDetailsViewController {
        return MovieDetailsViewController(
            viewModel: makeMovieDetailsViewModel(with: movieID),
            navigationDelegate: coordinator
        )
    }
    
    private func makeMovieDetailsViewModel(with movieID: Int) -> MovieDetailsViewModel {
        return MovieDetailsViewModel(
            movieID: movieID,
            navigationDelegate: coordinator,
            contentUseCase: MainContentUseCase(contentRepository: sharedContentRepository)
        )
    }
}
