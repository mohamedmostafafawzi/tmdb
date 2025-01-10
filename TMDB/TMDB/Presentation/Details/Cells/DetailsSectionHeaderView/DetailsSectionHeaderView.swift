// 
//  DetailsSectionHeaderView.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 10/01/2025.
//


import UIKit

public class DetailsSectionHeaderView: NiblessTableViewHeaderFooterView {
    
    // MARK: - Views
    private let titleLabel = UILabel().style(font: .bold(size: .h2),
                                             textColor: .headerText)
    
    // MARK: - Methods
    public func configure(with title: String) {
        titleLabel.text = title
    }
}

// MARK: - Layout
extension DetailsSectionHeaderView {
    public override func configureViewHierarchy() {
        // Configure title
        addAndConstraintToEdges(titleLabel, withSpacing: 16)
    }
}
