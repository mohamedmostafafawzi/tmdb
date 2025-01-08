// 
//  NavigationBarConfigurator.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//


import Foundation
import UIKit

/// Protocol that handles configuring navigation bar properties inside NavigationController
@objc public protocol NavigationBarConfigurator {
    var showsNavigationBar: Bool { get }
    var navigationBarTitle: String? { get }
}