// 
//  RootViewController.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//

import UIKit

class RootViewController: NiblessViewController {
    
    // MARK: - Properties
    public override var childForStatusBarStyle: UIViewController? {
        return children.first
    }

    open override var childForStatusBarHidden: UIViewController? {
        return children.first
    }
}
