// 
//  HomeViewController.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//


import UIKit
import RxSwift
import RxCocoa

public class HomeViewController: NiblessViewController {
    
    // MARK: - Properties
    private var rootView: HomeRootView!
    private let viewModel: HomeViewModel
    private weak var navigationDelegate: HomeViewControllerNavigationDelegate?
    public override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    private let disposeBag = DisposeBag()

    // MARK: - Initializer
    public init(viewModel: HomeViewModel,
                navigationDelegate: HomeViewControllerNavigationDelegate) {
        self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
        super.init()
    }
    
    // MARK: - Methods
    public override func loadView() {
        rootView = HomeRootView(
            tableViewDataSourceConfigurator: configureHomeTableView(tableView:)
        )
        view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.input.getPopularMovies.onNext(())
        
        bindLoading()
        bindSearchTextField()
        subscribeToPagination()
    }
    
    private func configureHomeTableView(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.output.homeSections.subscribe(onNext: { [unowned tableView] _ in
            tableView.reloadData()
        }).disposed(by: disposeBag)
        
    }
    
    private func subscribeToPagination() {
        self.viewModel.output.paginationManager.paginate(rootView.tableView) { [weak self] in
            guard let self else { return }
            self.viewModel.output.paginationManager.isPaginating.accept(true)
            viewModel.input.paginate.onNext(())
        }
    }
    
    private func bindSearchTextField() {
        rootView.searchTextField.textField.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.input.searchTFText)
            .disposed(by: disposeBag)
    }
    
    private func bindLoading() {
        viewModel.output.isLoading
            .drive(rootView.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
}

// MARK: - TableView DataSource and Delegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.output.homeSections.value.count
    }
    
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.output.homeSections.value[section].items.count
    }
    
    public func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(HomeSectionTableViewHeader.self)
        let section = viewModel.output.homeSections.value[section]
        header?.configure(with: section.title)
        return header
    }
    
    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(HomeTableViewCell.self)!
        let section = viewModel.output.homeSections.value[indexPath.section]
        let item = section.items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    public func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let section = viewModel.output.homeSections.value[indexPath.section]
        let item = section.items[indexPath.row]
        viewModel.input.homeItemSelected.onNext(item)
    }
}
