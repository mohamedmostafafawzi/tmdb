// 
//  PaginationManager.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 10/01/2025.
//


import RxSwift
import RxCocoa

class PaginationManager {
    
    // MARK: - Public Properties
    let totalPages: BehaviorRelay<Int>
    let pageNumber: BehaviorRelay<Int>
    let resetPagination = PublishSubject<()>()
    let isPaginating = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Private Properties
    private let disposeBag = DisposeBag()
    
    // MARK: - Private Subjects
    private let didReachedTheEndSubject = BehaviorRelay<Bool>(value: false)

    // MARK: - Initializer
    init() {
        self.pageNumber = BehaviorRelay<Int>(value:1)
        self.totalPages = BehaviorRelay<Int>(value: 1)
        
        subscribeToPaginationParameters()
        subscribeToResetPagination()
    }
    
    // MARK: - Event subscriptions
    private func subscribeToPaginationParameters() {
        Observable
            .combineLatest(pageNumber, totalPages)
            .subscribe(onNext: { [unowned self] pageNumber, totalPages in
                let totalPages = Int(ceil(Double(totalPages) / Double(pageNumber)))
                let didReachedTheEnd = pageNumber >= totalPages
                self.didReachedTheEndSubject.accept(didReachedTheEnd)
            }).disposed(by: disposeBag)
    }
    
    private func subscribeToResetPagination() {
        resetPagination.subscribe(onNext: { [unowned self] _ in
            self.pageNumber.accept(1)
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Internal logic
    func paginate(_ tableView: UITableView,  _ completion: @escaping () -> Void) {
        tableView.rx.paginate()
            .subscribe(onNext: { [weak self] in
                guard let self = self,
                      !self.didReachedTheEndSubject.value,
                      !self.isPaginating.value else { return }
                
                let pageNumber = self.pageNumber.value
                
                self.pageNumber.accept(pageNumber + 1)
                guard self.pageNumber.value > 1 else { return }
                completion()
            })
            .disposed(by: disposeBag)
    }
    
    func paginate(_ collectionView: UICollectionView, _ completion: @escaping () -> Void) {
        collectionView.rx.paginate()
            .subscribe(onNext: { [weak self] in
                guard let self = self,
                      !self.didReachedTheEndSubject.value,
                      !self.isPaginating.value else { return }

                let pageNumber = self.pageNumber.value

                self.pageNumber.accept(pageNumber + 1)
                guard self.pageNumber.value > 1 else { return }
                completion()
            })
            .disposed(by: disposeBag)
    }

}
