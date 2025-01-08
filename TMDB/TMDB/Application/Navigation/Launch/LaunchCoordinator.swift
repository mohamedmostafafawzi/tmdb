// 
//  LaunchCoordinator.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//

import UIKit

class LaunchCoordinator: Coordinator {
    
    // MARK: - Properties
    private let presenter: UIViewController
    private weak var navigationDelegate: LaunchCoordinatorNavigationDelegate?
    
    // MARK: View controllers
    private var launchVC: LaunchViewController?
    
    // MARK: Factories
    private let launchViewControllerFactory: LaunchViewControllerFactory
    
    // MARK: - Initializer
    init(
        presenter: UIViewController,
        navigationDelegate: LaunchCoordinatorNavigationDelegate,
        launchViewControllerFactory: LaunchViewControllerFactory
    ) {
        self.presenter = presenter
        self.navigationDelegate = navigationDelegate
        self.launchViewControllerFactory = launchViewControllerFactory
    }
    
    func start(
        completionHandler: CoordinatorStartCompletionHandler?
    ) {
        launchVC = launchViewControllerFactory.makeLaunchViewController()
        presenter.addFullScreen(childViewController: launchVC!)
        completionHandler?()
    }
    
    func finish(
        completionHandler: CoordinatorStartCompletionHandler?
    ) {
        launchVC?.removeFromParent()
        launchVC = nil
        completionHandler?()
    }
}

// MARK: - Navigation delegates
extension LaunchCoordinator: LaunchViewControllerNavigationDelegate {
    func goToHomeView() {
        navigationDelegate?.goToHomeView()
    }
}
