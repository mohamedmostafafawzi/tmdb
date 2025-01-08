// 
//  AppDependencyContainer.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//

import Foundation
import UIKit

public class AppDependencyContainer {
    
    // MARK: - Properties
    private let window: UIWindow
    private let rootVC: UIViewController
    
    // MARK: Long-lived dependencies
    private weak var sharedAppCoordinator: AppCoordinator!
    
    // MARK: - Initializer
    init(window: UIWindow) {
        // Initialize main properties
        self.window = window
        self.rootVC = RootViewController()
    }
    
    // MARK: - Methods
    public func makeAppCoordinator() -> AppCoordinator {
        let coordinator = AppCoordinator(
            window: window,
            rootVC: rootVC,
            launchCoordinatorFactory: self,
            homeCoordinatorFactory: self
        )
        self.sharedAppCoordinator = coordinator
        return coordinator
    }
}

// MARK: - Factories
extension AppDependencyContainer: LaunchCoordinatorFactory {
    func makeLaunchCoordinator() -> LaunchCoordinator {
        let launchDependencyContainer = LaunchDependencyContainer(
            presenter: rootVC,
            launchCoordinatorNavigationDelegate: sharedAppCoordinator
        )
        return launchDependencyContainer.makeAndStoreCoordinator()
    }
}

extension AppDependencyContainer: HomeCoordinatorFactory {
    func makeHomeCoordinator() -> HomeCoordinator {
        let homeDependencyContainer = HomeDependencyContainer(
            presenter: rootVC,
            homeCoordinatorNavigationDelegate: sharedAppCoordinator
        )
        return homeDependencyContainer.makeAndStoreCoordinator()
    }
}
