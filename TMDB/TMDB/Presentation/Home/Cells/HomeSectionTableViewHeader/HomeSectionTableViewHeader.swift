// 
//  HomeSectionTableViewHeader.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


import UIKit

/// The tableview section header grouping the search results with same year under one section
public class HomeSectionTableViewHeader: NiblessTableViewHeaderFooterView {
    
    // MARK: - Views
    private let titleLabel = UILabel().style(font: .bold(size: .h2),
                                             textColor: .headerText)
    
    // MARK: - Methods
    public func configure(with title: String) {
        titleLabel.text = title
    }
}

// MARK: - Layout
extension HomeSectionTableViewHeader {
    public override func configureViewHierarchy() {
        // Configure title
        addAndConstraintToEdges(titleLabel, withSpacing: 16)
    }
}
