// 
//  HomeViewController.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//


import UIKit

public class HomeViewController: NiblessViewController {
    
    // MARK: - Properties
    private var rootView: HomeRootView!
    private let viewModel: HomeViewModel
    private weak var navigationDelegate: HomeViewControllerNavigationDelegate?
    public override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    // MARK: - Initializer
    public init(viewModel: HomeViewModel,
                navigationDelegate: HomeViewControllerNavigationDelegate) {
        self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
        super.init()
    }
    
    // MARK: - Methods
    public override func loadView() {
        rootView = HomeRootView()
        view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
