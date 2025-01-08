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
    
    // MARK: - Initializer
    init(
        presenter: UIViewController,
        homeCoordinatorNavigationDelegate: HomeCoordinatorNavigationDelegate
    ) {
        self.presenter = presenter
        self.homeCoordinatorNavigationDelegate = homeCoordinatorNavigationDelegate
    }
    
    // MARK: - Methods
    func makeAndStoreCoordinator() -> HomeCoordinator {
        let coordinator = HomeCoordinator(
            presenter: presenter,
            navigationDelegate: homeCoordinatorNavigationDelegate,
            homeViewControllerFactory: self
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
            navigationDelegate: coordinator
        )
    }
}
