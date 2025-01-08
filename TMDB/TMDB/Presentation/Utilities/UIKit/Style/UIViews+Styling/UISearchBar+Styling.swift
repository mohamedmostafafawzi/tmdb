// 
//  UISearchBar+Styling.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 08/01/2025.
//


import UIKit

public extension UISearchBar {
    func style(
        placeholder: String,
        font: UIFont,
        textColor: UIColor
    ) -> Self {
        self.placeholder = placeholder
        self.searchTextField.font = font
        self.searchTextField.textColor = textColor
        self.backgroundImage = UIImage()
        return self
    }
}