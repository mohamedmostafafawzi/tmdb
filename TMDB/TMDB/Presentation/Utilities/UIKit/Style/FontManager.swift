// 
//  FontManager.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 08/01/2025.
//


import UIKit

// MARK: - Font Parts
public extension UIFont {
    enum FontWeight: String {
        case black = "Roboto-Black"
        case bold = "Roboto-Bold"
        case medium = "Roboto-Medium"
        case regular = "Roboto-Regular"
        case light = "Roboto-Light"
        case thin = "Roboto-Thin"

    }

    enum FontSize: CGFloat {
        case h1 = 30, h2 = 24, h3 = 18
        case bodyL = 16, bodyM = 14, bodyS = 11
    }
    
    static func getCustomFont(weight: FontWeight, size: CGFloat, scalable: Bool) -> UIFont {
        guard let customFont = UIFont(name: weight.rawValue, size: size) else {
            fatalError("Failed to load the \(weight.rawValue) font")
        }
        
        if scalable {
            let fontMetrics = UIFontMetrics(forTextStyle: .body)
            return fontMetrics.scaledFont(for: customFont)
        } else {
            return customFont
        }
    }
    
    /// Weight: 900
    static func black(size: FontSize, scalable: Bool = false) -> UIFont {
        return getCustomFont(weight: .black,
                             size: CGFloat(size.rawValue),
                             scalable: scalable)
    }
    /// Weight: 700
    static func bold(size: FontSize, scalable: Bool = false) -> UIFont {
        return getCustomFont(weight: .bold,
                             size: CGFloat(size.rawValue),
                             scalable: scalable)
    }

    /// Weight: 500
    static func medium(size: FontSize, scalable: Bool = false) -> UIFont {
        return getCustomFont(weight: .medium,
                             size: CGFloat(size.rawValue),
                             scalable: scalable)
    }
    /// Weight: 400
    static func regular(size: FontSize, scalable: Bool = false) -> UIFont {
        return getCustomFont(weight: .regular,
                             size: CGFloat(size.rawValue),
                             scalable: scalable)
    }
    /// Weight: 300
    static func light(size: FontSize, scalable: Bool = false) -> UIFont {
        return getCustomFont(weight: .light,
                             size: CGFloat(size.rawValue),
                             scalable: scalable)
    }
    /// Weight: 100
    static func thin(size: FontSize, scalable: Bool = false) -> UIFont {
        return getCustomFont(weight: .thin,
                             size: CGFloat(size.rawValue),
                             scalable: scalable)
    }
}
