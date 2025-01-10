// 
//  ColorManager.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 08/01/2025.
//


import UIKit

public extension UIColor {
    
    // MARK: - Text Semantic Colors
    static let headerText = evaluateColor(light: ColorPalette.darkGrey,
                                          dark: ColorPalette.white)
    static let headerPrimaryLightContentText = ColorPalette.black
    static let primaryText = evaluateColor(light: ColorPalette.darkestGrey,
                                           dark: ColorPalette.lightestGrey)
    static let secondaryText = evaluateColor(light: ColorPalette.darkGrey,
                                             dark: ColorPalette.lightGrey)
    
    static let primaryButtonText = ColorPalette.white
    static let headerLightContentText = ColorPalette.white
    static let primaryLightContentText = ColorPalette.lightestGrey
    static let secondaryLightContentText = ColorPalette.lightGrey
    static let primaryButtonLightContentText = ColorPalette.white
    
    // MARK: - Tint Semantic Colors
    static let primary = ColorPalette.darkBlue
    static let secondary = ColorPalette.lightBlue
    static let tertiary = ColorPalette.LightGreen
    static let destructive = ColorPalette.red
    
    // MARK: - Background Semantic Colors
    static let background = evaluateColor(light: ColorPalette.white,
                                          dark: ColorPalette.darkestGrey)
    static let secondaryBackground = evaluateColor(light: ColorPalette.lightestGrey,
                                                   dark: ColorPalette.black)
    static let cardViewBackground = evaluateColor(light: ColorPalette.lightestGrey,
                                                  dark: ColorPalette.darkGrey)
    static let primaryButtonBackground = evaluateColor(light: ColorPalette.red,
                                                       dark: ColorPalette.red)
    static let navigationBarBackground = evaluateColor(light: ColorPalette.white,
                                                       dark: ColorPalette.black)

    static let darkContentBackground = ColorPalette.darkestGrey
    static let lightContentBackground = ColorPalette.lightestGrey
    
    // MARK: - Others
    static let activityIndicator = evaluateColor(light: ColorPalette.darkGrey,
                                                 dark: ColorPalette.lightGrey)
}

/// Base palette, not visible outside this file
private struct ColorPalette {
    // App Colors
    static let darkBlue = UIColor(hex: "#0d253f")
    static let lightBlue = UIColor(hex: "#01b4e4")
    static let LightGreen = UIColor(hex: "#90cea1")

    // Others
    static let red = UIColor(hex: "#C62300")
    
    // Shades of black
    static let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let darkestGrey = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
    static let darkGrey = #colorLiteral(red: 0.2650472522, green: 0.2701303959, blue: 0.2834975719, alpha: 1)
    static let grey = #colorLiteral(red: 0.5490196078, green: 0.5490196078, blue: 0.5490196078, alpha: 1)
    static let lightGrey = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    static let lightestGrey = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
    static let white = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
}

// MARK: - Helpers
private func evaluateColor(light: UIColor, dark: UIColor) -> UIColor {
    return UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark ? dark : light
    }
}
