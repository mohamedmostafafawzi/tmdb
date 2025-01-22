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
    private var dataSource: UITableViewDiffableDataSource<HomeSectionViewModel, HomeCellViewModel>?
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
        tableView.delegate = self
        
        viewModel.output.homeSections.subscribe(onNext: { [weak self] _ in
            guard let self else { return }
            self.applySnapshot()
        }).disposed(by: disposeBag)
        
        viewModel.output.homeSections
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.applySnapshot()
            })
            .disposed(by: disposeBag)

        
        dataSource = UITableViewDiffableDataSource<HomeSectionViewModel, HomeCellViewModel>(
            tableView: tableView
        ) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(HomeTableViewCell.self)!
            cell.configure(with: item)
            return cell
        }

        dataSource?.defaultRowAnimation = .fade
        
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<HomeSectionViewModel, HomeCellViewModel>()
        let sections = viewModel.output.homeSections.value
        
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }

        dataSource?.apply(snapshot, animatingDifferences: true)
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

// MARK: - TableView Delegate
extension HomeViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else { return }
        viewModel.input.homeItemSelected.onNext(item)
    }

    public func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(HomeSectionTableViewHeader.self)
        let section = dataSource?.snapshot().sectionIdentifiers[section]
        header?.configure(with: section?.title ?? "")
        return header
    }
}
