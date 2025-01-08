// 
//  UIButton+Styling.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 08/01/2025.
//


import UIKit

public extension UIButton {
    func style(tintColor: UIColor? = nil,
               backgroundColor: UIColor? = nil,
               title: String? = nil,
               font: UIFont? = nil,
               image: UIImage? = nil,
               cornerRadius: CGFloat? = nil,
               spaceBetweenImageAndText: CGFloat? = nil,
               horizontalAlignment: UIControl.ContentHorizontalAlignment? = nil) -> UIButton {
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(self.tintColor, for: .normal)
        self.setImage(tintColor == nil ? image : image?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        if let font = font { self.titleLabel?.font = font }
        
        if let space = spaceBetweenImageAndText {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: space)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: space, bottom: 0, right: 0)
        }
        
        if let cornerRadius = cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        
        if let horizontalAlignment = horizontalAlignment {
            self.contentHorizontalAlignment = horizontalAlignment
        }
        
        return self
    }
}