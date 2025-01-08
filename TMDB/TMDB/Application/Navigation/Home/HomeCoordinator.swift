// 
//  HomeCoordinator.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    // MARK: - Properties
    private let presenter: UIViewController
    private weak var navigationDelegate: HomeCoordinatorNavigationDelegate?
    
    // MARK: View controllers
    private var homeVC: HomeViewController?
    
    // MARK: Factories
    private let homeViewControllerFactory: HomeViewControllerFactory
    
    // MARK: - Initializer
    init(
        presenter: UIViewController,
        navigationDelegate: HomeCoordinatorNavigationDelegate,
        homeViewControllerFactory: HomeViewControllerFactory
    ) {
        self.presenter = presenter
        self.navigationDelegate = navigationDelegate
        self.homeViewControllerFactory = homeViewControllerFactory
    }
    
    func start(
        completionHandler: CoordinatorStartCompletionHandler?
    ) {
        homeVC = homeViewControllerFactory.makeHomeViewController()
        presenter.addFullScreen(childViewController: homeVC!)
        completionHandler?()
    }
    
    func finish(
        completionHandler: CoordinatorStartCompletionHandler?
    ) {
        homeVC?.removeFromParent()
        homeVC = nil
        completionHandler?()
    }
}

// MARK: - Navigation delegates
extension HomeCoordinator: HomeViewControllerNavigationDelegate {
    
}
