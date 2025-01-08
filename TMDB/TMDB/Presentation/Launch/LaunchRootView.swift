// 
//  LaunchRootView.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//

import UIKit

class LaunchRootView: NiblessView {
    
    // MARK: - Views
    private let logoImageView = UIImageView().style(image: UIImage(named: "tmdb-launch-icon"),
                                                    contentMode: .scaleAspectFit)
    private let activityIndicator = UIActivityIndicatorView().style(color: .activityIndicator,
                                                                    style: .medium)
    
    // MARK: - Methods
    override func viewHierarchyDidConfigure() {
        backgroundColor = .background
        activityIndicator.startAnimating()
    }
}

// MARK: - Layout
extension LaunchRootView {
    override func configureViewHierarchy() {
        add(logoImageView, then: {
            $0.constrainHeight(150)
            $0.constrainWidth(150)
            $0.centerInSuperview()
        })
        
        add(activityIndicator, then: {
            $0.centerXToSuperview()
            $0.anchor(.top(logoImageView.bottomAnchor, constant: 100))
        })
    }
}
