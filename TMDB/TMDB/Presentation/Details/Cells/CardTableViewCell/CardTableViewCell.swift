// 
//  CardTableViewCell.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 10/01/2025.
//


import UIKit

public class CardTableViewCell: NiblessTableViewCell {
    
    // MARK: - Views
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 100, height: 190)
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return collectionView
    }()
    
    // MARK: - Properties
    private var items: [CardCellViewModel] = []
    
    // MARK: - Methods
    func configure(with items: [CardCellViewModel]) {
        configureCollectionView()
        
        self.items = items
        collectionView.reloadData()
    }
    
    public override func viewHierarchyDidConfigure() {
        backgroundColor = .clear
    }
}

// MARK: - Collection view data source
extension CardTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    private func configureCollectionView() {
        collectionView.registerCellFromClass(CardCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CardCollectionViewCell.self, for: indexPath)!
        let item = items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

// MARK: - Layout
extension CardTableViewCell {
    public override func configureViewHierarchy() {
        contentView.add(collectionView, then: {
            $0.fillSuperview()
            $0.constrainHeight(190)
        })
    }
}
