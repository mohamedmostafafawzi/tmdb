// 
//  NiblessCollectionReusableView.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//


import UIKit

open class NiblessCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Properties
    private var hierarchyNotReady = true
    
    // MARK: - Methods
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable,
    message: "Loading this view from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    open override func didMoveToWindow() {
        super.didMoveToWindow()
        
        guard hierarchyNotReady else {
            return
        }
        
        configureViewHierarchy()
        viewHierarchyDidConfigure()
        if let loaderView = loaderView { bringSubviewToFront(loaderView) }
        
        hierarchyNotReady = false
    }
    
    /// This is where all the view hierarchy setup should happen, it is called automatically in didMoveToWindow
    @objc dynamic open func configureViewHierarchy() {}
    
    /// This is called after the view hierarchy is configured.
    @objc dynamic open func viewHierarchyDidConfigure() {}
}