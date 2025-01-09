// 
//  SearchTextField.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


import UIKit

public class SearchTextField: NiblessView {
    
    // MARK: - Views
    private let cardView = UIView().style(backgroundColor: .cardViewBackground,
                                          cornerRadius: Dimensions.cornerRadius,
                                          shadowRadius: 15,
                                          shadowOpacity: 0.3)
    private let searchImageView = UIImageView().style(tintColor: .secondaryText,
                                                      image: UIImage(named: "search-icon"))
    public let textField: UITextField = { return CustomTextField() }()
    
    // MARK: - Properties
    public var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }
    
    public var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    // MARK: - Initializer
    public init(placeholder: String? = nil) {
        self.textField.placeholder = placeholder
        super.init(frame: .zero)
    }
    
    // MARK: - Layout
    public override func configureViewHierarchy() {
        cardView.add(searchImageView, then: {
            $0.anchor(.leading(cardView.leadingAnchor, constant: 16),
                      .topGreaterThanOrEqualTo(cardView.topAnchor),
                      .bottomGreaterThanOrEqualTo(cardView.bottomAnchor))
            $0.constrainHeight($0.widthAnchor)
            $0.constrainWidth(15)
            $0.centerYTo(cardView.centerYAnchor)
        })
        
        cardView.add(textField, then: {
            $0.anchor(.leading(searchImageView.trailingAnchor, constant: 8),
                      .top(cardView.topAnchor),
                      .trailing(cardView.trailingAnchor, constant: 16),
                      .bottom(cardView.bottomAnchor))
        })
        
        add(cardView, then: {
            $0.fillSuperview()
        })
    }
}

// MARK: - CustomTextField
private class CustomTextField: UITextField {
    
    // MARK: - Properties
    override var placeholder: String? {
        didSet {
            setColors()
        }
    }
    
    // MARK: - Initializer
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setColors()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setColors()
    }
    
    // MARK: - Methods
    private func setColors() {
        // Text
        tintColor = .primary
        textColor = .primaryText
        font = .regular(size: .bodyM)
        autocorrectionType = .no
        clipsToBounds = true
        returnKeyType = .search
        clearButtonMode = .always
        
        // Background
        backgroundColor = UIColor.clear
        
        // Placeholder
        let placeholder = self.placeholder != nil ? self.placeholder! : ""
        let placeholderFont: UIFont = .regular(size: .bodyM)
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.secondaryText,
                NSAttributedString.Key.font: placeholderFont
            ]
        )
    }
}
