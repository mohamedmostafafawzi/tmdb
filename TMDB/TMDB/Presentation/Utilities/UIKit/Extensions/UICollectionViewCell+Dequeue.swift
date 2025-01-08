// 
//  UICollectionViewCell+Dequeue.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//


import UIKit

extension UICollectionView {
    // MARK: - Cells registration & dequeuing
    /// Registers a cell from a class
    public func registerCellFromClass(_ type: UICollectionViewCell.Type) {
        let className = String(describing: type)
        register(
            type,
            forCellWithReuseIdentifier: className
        )
    }
    
    /// Registers a reusable header view from a class
    public func registerHeaderFromClass(_ type: UICollectionReusableView.Type) {
        let className = String(describing: type)
        register(
            type,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: className
        )
    }
    
    /// Dequeues a cell
    public func dequeueReusableCell<T>(_ type: T.Type, for indexPath: IndexPath) -> T? {
        let className = String(describing: type)
        return dequeueReusableCell(
            withReuseIdentifier: className,
            for: indexPath
        ) as? T
    }
    
    /// Dequeues a header
    public func dequeueHeader<T>(_ type: T.Type, for indexPath: IndexPath) -> T? {
        let className = String(describing: type)
        return dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: className,
            for: indexPath
        ) as? T
    }
}
