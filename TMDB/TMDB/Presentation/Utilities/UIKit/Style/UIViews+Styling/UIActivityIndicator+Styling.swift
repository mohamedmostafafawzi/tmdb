// 
//  UIActivityIndicator+Styling.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 08/01/2025.
//


import UIKit

public extension UIActivityIndicatorView {
    func style(color: UIColor? = .activityIndicator,
               style: Style = .medium) -> UIActivityIndicatorView {
        hidesWhenStopped = true
        if let color = color { self.color = color }
        self.style = style
        return self
    }
}