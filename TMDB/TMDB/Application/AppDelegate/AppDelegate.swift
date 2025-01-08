// 
//  AppDelegate.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    private var dependencyContainer: AppDependencyContainer!
    private var coordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configure and start coordinator
        configureAndStartCoordinator()
        return true
    }

}

extension AppDelegate {
    private func configureAndStartCoordinator() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        dependencyContainer = AppDependencyContainer(window: window)
        coordinator = dependencyContainer.makeAppCoordinator()
        coordinator.start()
    }
}

