// 
//  UIViewController+Containment.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//


import UIKit

extension UIViewController {
    
    // MARK: - Methods
    public func addFullScreen(childViewController child: UIViewController) {
        guard child.parent == nil else {
            return
        }
        
        removeAllChildren()
        
        addChild(child)
        view.add(child.view, then: {
            $0.fillSuperview()
        })
        
        child.didMove(toParent: self)
    }
    
    public func add(childViewController child: UIViewController, to containerView: UIView) {
        guard child.parent == nil else {
            return
        }
        
        addChild(child)
        containerView.add(child.view, then: {
            $0.fillSuperview()
        })
        
        child.didMove(toParent: self)
    }
    
    public func remove(childViewController child: UIViewController?) {
        guard let child = child else {
            return
        }
        
        guard child.parent != nil else {
            return
        }
        
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    public func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    public func removeAllChildren() {
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
}
