// 
//  AppCoordinator.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//

import UIKit

public class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    private let window: UIWindow
    private let rootVC: UIViewController

    // MARK: Child coordinators
    private var launchCoordinator: LaunchCoordinator?
    private var homeCoordinator: HomeCoordinator?
    
    // MARK: Factories
    private let launchCoordinatorFactory: LaunchCoordinatorFactory
    private let homeCoordinatorFactory: HomeCoordinatorFactory
    
    // MARK: - Initializer
    init(
        window: UIWindow,
        rootVC: UIViewController,
        launchCoordinatorFactory: LaunchCoordinatorFactory,
        homeCoordinatorFactory: HomeCoordinatorFactory
    ) {
        self.window = window
        self.rootVC = rootVC
        self.launchCoordinatorFactory = launchCoordinatorFactory
        self.homeCoordinatorFactory =  homeCoordinatorFactory
    }
    
    // MARK: - Methods
    public func start(
        completionHandler: CoordinatorStartCompletionHandler?
    ) {
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        goToLaunchView()
        completionHandler?()
    }
    
    public func finish(
        completionHandler: CoordinatorStartCompletionHandler?
    ) {
        completionHandler?()
    }
    
    private func goToLaunchView() {
        launchCoordinator = launchCoordinatorFactory.makeLaunchCoordinator()
        launchCoordinator?.start()
    }
    
}

extension AppCoordinator: LaunchCoordinatorNavigationDelegate {
    func goToHomeView() {
        homeCoordinator = homeCoordinatorFactory.makeHomeCoordinator()
        homeCoordinator?.start()
    }
}

extension AppCoordinator: HomeCoordinatorNavigationDelegate {

}
