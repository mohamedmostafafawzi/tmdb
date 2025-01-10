// 
//  RxTableView+Pagination.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 10/01/2025.
//


import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {
    /// Creates an observable sequence that emits a signal when the user scrolls close to the bottom of the table view, 
    /// indicating a desire for pagination.
    ///
    /// - Parameters:
    ///   - triggerOffset: The offset from the bottom of the content where the pagination signal should be triggered. 
    ///   Default is 100.
    ///
    /// - Returns: An observable sequence that emits a signal when pagination is triggered.
    func paginate(triggerOffset: CGFloat = 100) -> Observable<Void> {
        return didScroll
            .flatMap { [weak base] _ -> Observable<Void> in
                guard let tableView = base else { return Observable.empty() }

                let offSetY = tableView.contentOffset.y
                let contentHeight = tableView.contentSize.height

                if offSetY > (contentHeight - tableView.frame.size.height - triggerOffset) {
                    return Observable.just(())
                }

                return Observable.empty()
            }
    }
}