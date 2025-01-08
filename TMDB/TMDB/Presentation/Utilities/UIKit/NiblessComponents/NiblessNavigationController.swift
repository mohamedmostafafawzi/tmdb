// 
//  NiblessNavigationController.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//


import UIKit

open class NiblessNavigationController: UINavigationController {
    
    // MARK: - Properties
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    open override var childForStatusBarHidden: UIViewController? {
        return topViewController
    }
    
    private lazy var popGestureRecognizer = InteractivePopRecognizer(controller: self)
    
    // MARK: - Methods
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure pop gesture recognizer
        interactivePopGestureRecognizer?.delegate = popGestureRecognizer
    }
    
    @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    }
}

// MARK: - Pop gesture recognizer
/// Implemented as a workaround to enable back gesture when navigation bar is hidden
class InteractivePopRecognizer: NSObject, UIGestureRecognizerDelegate {

    weak var navigationController: UINavigationController?

    init(controller: UINavigationController) {
        self.navigationController = controller
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return (navigationController?.viewControllers.count ?? 0) > 1
    }

    // This is necessary because without it, subviews of your top controller can
    // cancel out your gesture recognizer on the edge.
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}