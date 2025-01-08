// 
//  HomeViewModel.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//



public class HomeViewModel: ViewModelType {
    
    // MARK: - Input & Output
    public var input: HomeViewModel.Input
    public var output: HomeViewModel.Output
    
    public struct Input { }
    
    public struct Output { }
        
    // MARK: - Subjects
    
    // MARK: - Properties
    private weak var navigationDelegate: HomeViewControllerNavigationDelegate?
    
    // MARK: - Initializer
    public init(navigationDelegate: HomeViewControllerNavigationDelegate) {
        
        self.navigationDelegate = navigationDelegate
        
        // Configure input & output
        input = Input()
        output = Output()
        
        // Subscribe for input events

    }
    
    // MARK: - Internal logic

    
    // MARK: - Input events subscription

}
