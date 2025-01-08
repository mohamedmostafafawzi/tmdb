// 
//  ConfigurableCell.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//


import Foundation

protocol ConfigurableCell {
    associatedtype Model
    
    func configure(with: Model)
}