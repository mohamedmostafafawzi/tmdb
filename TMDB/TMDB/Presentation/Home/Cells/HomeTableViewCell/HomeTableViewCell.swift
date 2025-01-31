// 
//  HomeTableViewCell.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


import UIKit

/// Represents a single item in the vertical list of the search results.
/// It can be any type of item in search results
public class HomeTableViewCell: NiblessTableViewCell {
    
    // MARK: - Views
    private let cardView = UIView().style(backgroundColor: .cardViewBackground,
                                          cornerRadius: Dimensions.cornerRadius)
    let posterImageView = UIImageView().style(image: UIImage(named: "poster-placeholder"),
                                              contentMode: .scaleAspectFill,
                                              cornerRadius: Dimensions.cornerRadius)
    let titleLabel = UILabel().style(font: .bold(size: .bodyM),
                                     textColor: .primaryText,
                                     numberOfLines: 1)
    let overviewLabel = UILabel().style(font: .regular(size: .bodyS),
                                        textColor: .secondaryText)
    let isOnWatchlistImageView = UIImageView().style(image: UIImage(systemName: "bookmark.fill"),
                                                     contentMode: .scaleAspectFill,
                                                     cornerRadius: Dimensions.cornerRadius)

    
    // MARK: - Properties
    private var viewModel: HomeCellViewModel?
    
    // MARK: - Methods
    public func configure(with viewModel: HomeCellViewModel) {
        self.viewModel = viewModel
        posterImageView.setImage(
            url: viewModel.imageURL,
            placeholder: UIImage(named: "poster-placeholder")
        )
        titleLabel.text = viewModel.title
        overviewLabel.text = viewModel.overview
        isOnWatchlistImageView.tintColor = viewModel.isOnWatchlist ? .tertiary : .secondary
        isOnWatchlistImageView.image = viewModel.isOnWatchlist ?
        UIImage(systemName: "bookmark.fill"):
        UIImage(systemName: "bookmark")

    }
    
    public override func viewHierarchyDidConfigure() {
        selectionStyle = .none
        backgroundColor = .clear
    }
}

// MARK: - Layout
extension HomeTableViewCell {
    public override func configureViewHierarchy() {
        // Configure cover image
        cardView.add(posterImageView, then: {
            $0.anchor(.leading(cardView.leadingAnchor),
                      .top(cardView.topAnchor),
                      .bottom(cardView.bottomAnchor))
            $0.constrainHeight(120)
            $0.constrainWidth(80)
        })
        
        // Configure watchlist status
        cardView.add(isOnWatchlistImageView, then: {
            $0.anchor(.top(cardView.topAnchor, constant: 8),
                      .trailing(cardView.trailingAnchor, constant: 8))
            $0.constrainHeight(20)
            $0.constrainWidth(20)
        })
        
        // Configure info
        let infoStackView = configureInfoStackView()
        cardView.add(infoStackView, then: {
            $0.anchor(.leading(posterImageView.trailingAnchor, constant: 16),
                      .top(cardView.topAnchor, constant: 8),
                      .trailing(isOnWatchlistImageView.leadingAnchor, constant: 4),
                      .bottomGreaterThanOrEqualTo(cardView.bottomAnchor, constant: 8))
        })
        
        // Configure cardview
        contentView.add(cardView, then: {
            $0.anchor(.leading(contentView.leadingAnchor, constant: 16),
                      .top(contentView.topAnchor),
                      .trailing(contentView.trailingAnchor, constant: 16),
                      .bottom(contentView.bottomAnchor, constant: 10))
        })
    }
    
    private func configureInfoStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, overviewLabel])
        stackView.alignment = .top
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.add(titleLabel)
        stackView.add(overviewLabel)
        
        return stackView
    }
}
