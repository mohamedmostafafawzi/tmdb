// 
//  MovieDetailsViewController.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 10/01/2025.
//


import UIKit
import RxSwift
import RxCocoa

public class MovieDetailsViewController: NiblessViewController {
    
    // MARK: - Properties
    private var rootView: MovieDetailsRootView!
    private let viewModel: MovieDetailsViewModel
    private weak var navigationDelegate: MovieDetailsViewControllerNavigationDelegate?
    public override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    private let disposeBag = DisposeBag()

    // MARK: - Initializer
    public init(viewModel: MovieDetailsViewModel,
                navigationDelegate: MovieDetailsViewControllerNavigationDelegate) {
        self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
        super.init()
    }
    
    // MARK: - Methods
    public override func loadView() {
        rootView = MovieDetailsRootView(
            tableViewDataSourceConfigurator: configureMovieDetailsTableView(tableView:)
        )
        view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.input.getDetails.onNext(())
    }
    
    private func configureMovieDetailsTableView(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        
        Observable.combineLatest(viewModel.output.movieDetails,
                                 viewModel.output.similarMovies,
                                 viewModel.output.actors,
                                 viewModel.output.directors)
        .subscribe(onNext: { [unowned tableView] _ in
            tableView.reloadData()
        }).disposed(by: disposeBag)
        
    }
    
}

// MARK: - TableView DataSource and Delegate
extension MovieDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 1
    }
    
    public func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        switch section {
        case 1:
            let header = tableView.dequeueReusableHeaderFooterView(DetailsSectionHeaderView.self)
            header?.configure(with: "Similar Movies")
            return header
        case 2:
            let header = tableView.dequeueReusableHeaderFooterView(DetailsSectionHeaderView.self)
            header?.configure(with: "Actors")
            return header
        case 3:
            let header = tableView.dequeueReusableHeaderFooterView(DetailsSectionHeaderView.self)
            header?.configure(with: "Directors")
            return header
        default:
            return nil
        }
    }
    
    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(DetailsTableViewCell.self)!
            cell.addToWishlistTapped = { [unowned self] movieID in
                self.viewModel.input.addToWishlistSelected.onNext(movieID)
            }
            if let item = viewModel.output.movieDetails.value {
                cell.configure(with: item)
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(CardTableViewCell.self)!
            let items = viewModel.output.similarMovies.value
            cell.configure(with: items)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(CardTableViewCell.self)!
            let items = viewModel.output.actors.value
            cell.configure(with: items)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(CardTableViewCell.self)!
            let items = viewModel.output.directors.value
            cell.configure(with: items)
            return cell
        default:
            fatalError("Unsupported section in tracks list table view")
        }
    }
    
}
