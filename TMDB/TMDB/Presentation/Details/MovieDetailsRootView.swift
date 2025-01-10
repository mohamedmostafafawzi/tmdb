// 
//  MovieDetailsRootView.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 10/01/2025.
//


import UIKit

class MovieDetailsRootView: NiblessView {
    
    // MARK: - Views
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0)
        return tableView
    }()
    
    // MARK: - Initializer
    init(tableViewDataSourceConfigurator: TableViewDataSourceConfigurator) {
        tableViewDataSourceConfigurator(tableView)
        super.init(frame: .zero)
    }
    
    // MARK: - Methods
    override func viewHierarchyDidConfigure() {
        backgroundColor = .background
        
        tableView.setLoaderColor(to: .activityIndicator)
        tableView.registerHeaderFooterViewFromClass(DetailsSectionHeaderView.self)
        tableView.registerCellFromClass(DetailsTableViewCell.self)
        tableView.registerCellFromClass(CardTableViewCell.self)
    }
}

// MARK: - Layout
extension MovieDetailsRootView {
    override func configureViewHierarchy() {
        // Configure table view
        add(tableView, then: {
            $0.anchor(.leading(safeAreaLayoutGuide.leadingAnchor),
                      .top(safeAreaLayoutGuide.topAnchor, constant: 16),
                      .trailing(safeAreaLayoutGuide.trailingAnchor),
                      .bottom(safeAreaLayoutGuide.bottomAnchor))
        })
    }
}
