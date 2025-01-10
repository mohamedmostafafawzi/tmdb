// 
//  HomeViewControllerNavigationDelegate.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//


import Foundation

public protocol HomeViewControllerNavigationDelegate: AnyObject {
    func viewDetails(of movieID: Int)
}
