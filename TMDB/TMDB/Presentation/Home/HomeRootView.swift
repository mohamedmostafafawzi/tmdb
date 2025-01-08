// 
//  HomeRootView.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//


import UIKit

class HomeRootView: NiblessView {
    
    // MARK: - Views
    private let logoImageView = UIImageView().style(image: UIImage(named: "tmdb-home-icon"),
                                                    contentMode: .scaleAspectFit)
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
    }
    
    // MARK: - Methods
    override func viewHierarchyDidConfigure() {
        backgroundColor = .background
    }
}

// MARK: - Layout
extension HomeRootView {
    override func configureViewHierarchy() {
        add(logoImageView, then: {
            $0.anchor(.top(safeAreaLayoutGuide.topAnchor, constant: 8))
            $0.constrainHeight(50)
            $0.constrainWidth(150)
            $0.centerXToSuperview()
        })
    }
}
