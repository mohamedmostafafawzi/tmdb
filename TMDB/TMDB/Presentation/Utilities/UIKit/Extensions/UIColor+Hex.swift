// 
//  UIColor+Hex.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//


import UIKit

extension UIColor {
    
    /**
     Creates an UIColor from HEX String in "#363636" format
     
     - parameter hex: HEX String in "#363636" format
     - parameter alpha: The alpha factor in 0 to 1.0 format
     - returns: UIColor from HexString
     */
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex
            .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            .uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    /**
     Creates an UIColor Object based on provided RGB value in integer
     - parameter red:   Red Value in integer (0-255)
     - parameter green: Green Value in integer (0-255)
     - parameter blue:  Blue Value in integer (0-255)
     - returns: UIColor with specified RGB values
     */
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green)
                    / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}