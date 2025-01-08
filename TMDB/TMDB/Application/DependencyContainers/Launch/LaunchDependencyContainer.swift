// 
//  LaunchDependencyContainer.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//

import UIKit

class LaunchDependencyContainer: DependencyContainer {
    
    // MARK: - Properties
    private weak var coordinator: LaunchCoordinator!
    private weak var launchCoordinatorNavigationDelegate: LaunchCoordinatorNavigationDelegate!
    private let presenter: UIViewController
    
    // MARK: - Initializer
    init(
        presenter: UIViewController,
        launchCoordinatorNavigationDelegate: LaunchCoordinatorNavigationDelegate
    ) {
        self.presenter = presenter
        self.launchCoordinatorNavigationDelegate = launchCoordinatorNavigationDelegate
    }
    
    // MARK: - Methods
    func makeAndStoreCoordinator() -> LaunchCoordinator {
        let coordinator = LaunchCoordinator(
            presenter: presenter,
            navigationDelegate: launchCoordinatorNavigationDelegate,
            launchViewControllerFactory: self
        )
        self.coordinator = coordinator
        return coordinator
    }
}

// MARK: - Factories
extension LaunchDependencyContainer: LaunchViewControllerFactory {
    func makeLaunchViewController() -> LaunchViewController {
        return LaunchViewController(
            viewModel: makeLaunchViewModel(),
            navigationDelegate: coordinator
        )
    }
    
    private func makeLaunchViewModel() -> LaunchViewModel {
        return LaunchViewModel()
    }
}
