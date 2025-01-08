// 
//  UIView+Styling.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 08/01/2025.
//


import UIKit

public extension UIView {
    func style(backgroundColor: UIColor? = nil,
               alpha: CGFloat = 1,
               cornerRadius: CGFloat? = nil,
               maskedCorners: CACornerMask? = nil,
               shadowColor: UIColor? = nil,
               shadowRadius: CGFloat? = nil,
               shadowOpacity: Float? = nil) -> Self {
        if let backgroundColor = backgroundColor { self.backgroundColor = backgroundColor }
        self.alpha = alpha
        if let cornerRadius = cornerRadius { self.layer.cornerRadius = cornerRadius }
        if let maskedCorners = maskedCorners { self.layer.maskedCorners = maskedCorners }
        if let shadowColor = shadowColor { self.layer.shadowColor = shadowColor.cgColor; clipsToBounds = false }
        if let shadowRadius = shadowRadius { self.layer.shadowRadius = shadowRadius; clipsToBounds = false }
        if let shadowOpacity = shadowOpacity { self.layer.shadowOpacity = shadowOpacity; clipsToBounds = false }
        return self
    }
}