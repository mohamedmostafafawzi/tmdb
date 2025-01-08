// 
//  UIImageView+Styling.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 08/01/2025.
//


import UIKit

public extension UIImageView {
    @discardableResult
    func style(tintColor: UIColor? = nil,
               image: UIImage? = nil,
               contentMode: UIImageView.ContentMode = .scaleAspectFit,
               cornerRadius: CGFloat? = nil,
               maskedCorners: CACornerMask? = nil,
               clipsToBounds: Bool = true) -> UIImageView {
        self.tintColor = tintColor
        self.image = tintColor == nil ? image : image?.withRenderingMode(.alwaysTemplate)
        self.contentMode = contentMode
        if let cornerRadius = cornerRadius { self.layer.cornerRadius = cornerRadius }
        if let maskedCorners = maskedCorners { self.layer.maskedCorners = maskedCorners }
        self.clipsToBounds = clipsToBounds
        return self
    }
}