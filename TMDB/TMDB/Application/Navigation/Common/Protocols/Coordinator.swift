// 
//  Coordinator.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//

import UIKit

public typealias CoordinatorStartCompletionHandler = () -> Void
public typealias CoordinatorFinishCompletionHandler = () -> Void

/**
 A coordinator is responsible for navigation between views.
 No view should be able to navigate on its own, that's a responsibility for its coordinator.
 It should have a start and a finish, each with an optional completion handler.
 */
public protocol Coordinator {
    /// Starts the coordinator flow
    func start(completionHandler: CoordinatorStartCompletionHandler?)
    
    /// Finishes the coordinator flow
    func finish(completionHandler: CoordinatorStartCompletionHandler?)
}

extension Coordinator {
    public func start() {
        start(completionHandler: nil)
    }
    
    public func finish() {
        finish(completionHandler: nil)
    }
}
