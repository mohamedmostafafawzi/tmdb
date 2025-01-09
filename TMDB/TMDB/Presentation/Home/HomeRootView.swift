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
    let searchTextField = SearchTextField(placeholder: "Discover movies...")
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0)
        return tableView
    }()
    let activityIndicator = UIActivityIndicatorView().style(color: .activityIndicator,
                                                            style: .medium)
    
    // MARK: - Initializer
    init(tableViewDataSourceConfigurator: TableViewDataSourceConfigurator) {
        tableViewDataSourceConfigurator(tableView)
        super.init(frame: .zero)
    }
    
    // MARK: - Methods
    override func viewHierarchyDidConfigure() {
        backgroundColor = .background
        
        tableView.setLoaderColor(to: .activityIndicator)
        tableView.registerHeaderFooterViewFromClass(HomeSectionTableViewHeader.self)
        tableView.registerCellFromClass(HomeTableViewCell.self)
        
        tableView.tableFooterView = activityIndicator
        activityIndicator.hidesWhenStopped = true
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
        add(searchTextField, then: {
            $0.anchor(.leading(safeAreaLayoutGuide.leadingAnchor, constant: 16),
                      .top(logoImageView.bottomAnchor, constant: 8),
                      .trailing(safeAreaLayoutGuide.trailingAnchor, constant: 16))
            $0.constrainHeight(40)
        })
        // Configure results items table view
        add(tableView, then: {
            $0.anchor(.leading(safeAreaLayoutGuide.leadingAnchor),
                      .top(searchTextField.bottomAnchor, constant: 16),
                      .trailing(safeAreaLayoutGuide.trailingAnchor),
                      .bottom(safeAreaLayoutGuide.bottomAnchor))
        })
    }
}
