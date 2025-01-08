// 
//  LaunchViewModel.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//


import Foundation

public class LaunchViewModel: ViewModelType {
    
    // MARK: - Input & Output
    public var input: LaunchViewModel.Input
    public var output: LaunchViewModel.Output
    
    public struct Input { }
    
    public struct Output { }
    
    // MARK: - Properties
    
    // MARK: - Subjects
    
    // MARK: - Initializer
    public init() {
        // Configure input & output
        input = Input()
        output = Output()
        
        // Subscribe for input events
    }
    
    // MARK: - Internal logic
    
    // MARK: - Input events subscription

}
