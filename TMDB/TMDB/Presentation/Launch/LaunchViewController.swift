// 
//  LaunchViewController.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//

import UIKit

public class LaunchViewController: NiblessViewController {
    
    // MARK: - Properties
    private var rootView: LaunchRootView!
    private let viewModel: LaunchViewModel
    private weak var navigationDelegate: LaunchViewControllerNavigationDelegate?
    public override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    // MARK: - Initializer
    public init(viewModel: LaunchViewModel,
                navigationDelegate: LaunchViewControllerNavigationDelegate) {
        self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
        super.init()
    }
    
    // MARK: - Methods
    public override func loadView() {
        rootView = LaunchRootView()
        view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: - Load configration before navigating to home.
        // Mimic a fetch configration in the background of launch
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) { [weak self] in
            guard let self else { return }
            navigationDelegate?.goToHomeView()
        }
    }
}
