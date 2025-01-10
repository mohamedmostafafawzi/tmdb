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
    private let movieDetailsViewControllerFactory: MovieDetailsViewControllerFactory
    
    // MARK: - Initializer
    init(
        presenter: UIViewController,
        navigationDelegate: HomeCoordinatorNavigationDelegate,
        homeViewControllerFactory: HomeViewControllerFactory,
        movieDetailsViewControllerFactory: MovieDetailsViewControllerFactory
    ) {
        self.presenter = presenter
        self.navigationDelegate = navigationDelegate
        self.homeViewControllerFactory = homeViewControllerFactory
        self.movieDetailsViewControllerFactory = movieDetailsViewControllerFactory
    }
    
    func start(
        completionHandler: CoordinatorStartCompletionHandler?
    ) {
        homeVC = homeViewControllerFactory.makeHomeViewController()
        let navigationVC = UINavigationController(rootViewController: homeVC!)
        presenter.addFullScreen(childViewController: navigationVC)
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
    func viewDetails(of movieID: Int) {
        let movieDetailsVC = movieDetailsViewControllerFactory.makeMovieDetailsViewController(with: movieID)
        homeVC?.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}

extension HomeCoordinator: MovieDetailsViewControllerNavigationDelegate {
    
}
