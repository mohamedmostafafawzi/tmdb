// 
//  CardCollectionViewCell.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 10/01/2025.
//


import UIKit

public class CardCollectionViewCell: NiblessCollectionViewCell {
    
    // MARK: - Views
    private let cardImageView = UIImageView().style(image: UIImage(named: "poster-placeholder"),
                                                     contentMode: .scaleAspectFill,
                                                     cornerRadius: Dimensions.cornerRadius)
    private let titleLabel = UILabel().style(font: .bold(size: .bodyL),
                                             textColor: .primaryText,
                                             textAlignment: .left,
                                             numberOfLines: 1)
    
    // MARK: - Methods
    func configure(with viewModel: CardCellViewModel) {
        cardImageView.setImage(
            url: viewModel.imageURL,
            placeholder: UIImage(named: "poster-placeholder")
        )
        titleLabel.text = viewModel.name
    }
    
    public override func viewHierarchyDidConfigure() {
        backgroundColor = .clear
    }
}

// MARK: - Layout
extension CardCollectionViewCell {
    public override func configureViewHierarchy() {
        contentView.add(cardImageView, then: {
            $0.anchor(.leading(contentView.leadingAnchor),
                      .top(contentView.topAnchor),
                      .trailing(contentView.trailingAnchor, constant: 16))
            $0.constrainHeight($0.widthAnchor, priority: .defaultLow)
        })
        
        contentView.add(titleLabel, then: {
            $0.anchor(.leading(cardImageView.leadingAnchor, constant: 8),
                      .top(cardImageView.bottomAnchor, constant: 8),
                      .trailing(cardImageView.trailingAnchor, constant: 8),
                      .bottom(contentView.bottomAnchor))
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
        })
    }
}
