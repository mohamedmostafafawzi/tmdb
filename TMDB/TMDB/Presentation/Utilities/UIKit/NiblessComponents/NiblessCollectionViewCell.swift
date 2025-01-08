// 
//  NiblessCollectionViewCell.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//


import UIKit

/// A collection cell class that's written purely in code without storyboards.
open class NiblessCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static public var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - Methods
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViewHierarchy()
        viewHierarchyDidConfigure()
    }
    
    @available(*, unavailable,
    message: "Loading this view from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    /// This is where all the view hierarchy setup should happen, it is called automatically in didMoveToWindow
    @objc dynamic open func configureViewHierarchy() {}
    
    /// This is called after the view hierarchy is configured.
    @objc dynamic open func viewHierarchyDidConfigure() {}
}
