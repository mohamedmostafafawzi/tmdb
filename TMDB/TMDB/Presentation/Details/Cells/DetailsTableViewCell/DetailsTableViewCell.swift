// 
//  DetailsTableViewCell.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 10/01/2025.
//


import UIKit

public class DetailsTableViewCell: NiblessTableViewCell {
    
    // MARK: - Views
    private let cardView = UIView().style(backgroundColor: .cardViewBackground,
                                          cornerRadius: Dimensions.cornerRadius)
    let posterImageView = UIImageView().style(image: UIImage(named: "poster-placeholder"),
                                              contentMode: .scaleAspectFill,
                                              cornerRadius: Dimensions.cornerRadius)
    let backDropImageView = UIImageView().style(image: UIImage(named: "poster-placeholder"),
                                                contentMode: .scaleAspectFill,
                                                cornerRadius: Dimensions.cornerRadius,
                                                maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    private let backDropImageOverlay = UIView().style(backgroundColor: .black.withAlphaComponent(0.7),
                                                   cornerRadius: Dimensions.mediumCornerRadius)
    let titleLabel = UILabel().style(font: .bold(size: .bodyL),
                                     textColor: .primaryText)
    let taglineLabel = UILabel().style(font: .medium(size: .bodyM),
                                       textColor: .secondaryText)
    let revenueLabel = UILabel().style(font: .medium(size: .bodyS),
                                       textColor: .secondaryText)
    let releaseDateLabel = UILabel().style(font: .medium(size: .bodyS),
                                           textColor: .secondaryText)
    let statusLabel = UILabel().style(font: .medium(size: .bodyS),
                                      textColor: .secondaryText)
    
    let overviewLabel = UILabel().style(font: .regular(size: .bodyM),
                                        textColor: .secondaryText)
    let isOnWatchlistImageView = UIImageView().style(tintColor: .white,
                                                     image: UIImage(systemName: "bookmark.fill"),
                                                     contentMode: .scaleAspectFill,
                                                     cornerRadius: Dimensions.cornerRadius)
    
    // MARK: - Properties
    private var viewModel: DetailsCellViewModel?
    public var wishlistTapped: ((DetailsCellViewModel) -> Void)?
    
    // MARK: - Methods
    public func configure(with viewModel: DetailsCellViewModel) {
        self.viewModel = viewModel
        posterImageView.setImage(
            url: viewModel.posterURL,
            placeholder: UIImage(named: "poster-placeholder")
        )
        backDropImageView.setImage(
            url: viewModel.backDropURL,
            placeholder: UIImage(named: "poster-placeholder")
        )
        titleLabel.text = viewModel.title
        taglineLabel.text = viewModel.tagline
        releaseDateLabel.text = viewModel.releaseDate
        statusLabel.text = viewModel.status
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        
        let revenueString = formatter.string(from: NSNumber(value: viewModel.revenue)) ?? "$0.00"
        
        revenueLabel.text = revenueString
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
    
    @objc private func wishlistTapped(_ sender: UITapGestureRecognizer) {
        guard let viewModel = self.viewModel else { return }
        wishlistTapped?(viewModel)
    }
}

// MARK: - Layout
extension DetailsTableViewCell {
    public override func configureViewHierarchy() {
        // Configure backdrop image
        cardView.add(backDropImageView, then: {
            $0.anchor(.leading(cardView.leadingAnchor),
                      .trailing(cardView.trailingAnchor),
                      .top(cardView.topAnchor))
            $0.constrainHeight(150)
        })
        
        cardView.add(backDropImageOverlay, then: {
            $0.anchor(.leading(cardView.leadingAnchor),
                      .trailing(cardView.trailingAnchor),
                      .top(cardView.topAnchor))
            $0.constrainHeight(150)
        })
        
        // Configure cover image
        cardView.add(posterImageView, then: {
            $0.anchor(.leading(cardView.leadingAnchor, constant: 16),
                      .top(cardView.topAnchor, constant: 90))
            $0.constrainWidth(150)
            $0.constrainHeight($0.widthAnchor, multiplier: 1.5)
        })
        
        // Configure watchlist status
        cardView.add(isOnWatchlistImageView, then: {
            $0.anchor(.top(cardView.topAnchor, constant: 8),
                      .trailing(cardView.trailingAnchor, constant: 8))
            $0.constrainHeight(20)
            $0.constrainWidth(20)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(wishlistTapped(_:)))
            $0.addGestureRecognizer(tapGesture)
            $0.isUserInteractionEnabled = true
        })
        
        // Configure info
        let infoStackView = configureInfoStackView()
        cardView.add(infoStackView, then: {
            $0.anchor(.leading(posterImageView.trailingAnchor, constant: 16),
                      .trailing(isOnWatchlistImageView.leadingAnchor, constant: 4),
                      .bottom(posterImageView.bottomAnchor, constant: 8))
        })
        
        // Configure watchlist status
        cardView.add(overviewLabel, then: {
            $0.anchor(.top(posterImageView.bottomAnchor, constant: 8),
                      .leading(cardView.leadingAnchor, constant: 16),
                      .trailing(cardView.trailingAnchor, constant: 16),
                      .bottomGreaterThanOrEqualTo(cardView.bottomAnchor, constant: 16))
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
        let stackView = UIStackView(arrangedSubviews: [titleLabel, taglineLabel ,releaseDateLabel, revenueLabel, statusLabel])
        stackView.alignment = .top
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.add(titleLabel)
        stackView.add(taglineLabel)
        stackView.add(releaseDateLabel)
        stackView.add(revenueLabel)
        stackView.add(statusLabel)
        
        return stackView
    }
}
