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
                                    textColor: .secondaryText,
                                    numberOfLines: 1)
    let releaseYearLabel = UILabel().style(font: .regular(size: .bodyS),
                                    textColor: .secondaryText,
                                    numberOfLines: 1)
    // TODO: - Add watchlist state image
    let isOnWatchlistImageView = UIImageView().style(image: UIImage(systemName: "star.fill"),
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
        releaseYearLabel.text = viewModel.releaseYear
        
        isOnWatchlistImageView.isHidden = !viewModel.isOnWatchlist
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
            $0.constrainHeight(1500)
            $0.constrainWidth(500)
        })
        
        // Configure info
        let infoStackView = configureInfoStackView()
        cardView.add(infoStackView, then: {
            $0.anchor(.leading(posterImageView.trailingAnchor, constant: 16),
                      .topGreaterThanOrEqualTo(cardView.topAnchor, constant: 8),
                      .trailing(cardView.leadingAnchor, constant: 16),
                      .bottomGreaterThanOrEqualTo(cardView.bottomAnchor, constant: 8))
            $0.centerYTo(posterImageView.centerYAnchor)
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
        let stackView = UIStackView(arrangedSubviews: [titleLabel, overviewLabel, releaseYearLabel, isOnWatchlistImageView])
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.add(titleLabel)
        stackView.add(overviewLabel)
        stackView.add(releaseYearLabel)
        stackView.add(isOnWatchlistImageView)
        
        return stackView
    }
}
