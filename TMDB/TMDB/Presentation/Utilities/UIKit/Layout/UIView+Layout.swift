// 
//  UIView+Layout.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 07/01/2025.
//


import UIKit

public enum Anchor {
    case top(_ top: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required)
    case topGreaterThanOrEqualTo(_ top: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required)
    case leading(_ leading: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required)
    case leadingGreaterThanOrEqualTo(_ leading: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required)
    case bottom(_ bottom: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required)
    case bottomGreaterThanOrEqualTo(_ bottom: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required)
    case trailing(_ trailing: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required)
    case trailingGreaterThanOrEqualTo(_ trailing: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required)
    case heightConstant(_ constant: CGFloat, priority: UILayoutPriority = .required)
    case height(_ dimension: NSLayoutDimension, multiplier: CGFloat, priority: UILayoutPriority = .required)
    case widthConstant(_ constant: CGFloat, priority: UILayoutPriority = .required)
    case width(_ dimension: NSLayoutDimension, multiplier: CGFloat, priority: UILayoutPriority = .required)
}

extension UIView {
    @discardableResult
    public func anchor(_ anchors: Anchor...) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchors.forEach { anchor in
            switch anchor {
            case .top(let anchor, let constant, let priority):
                anchoredConstraints.top = topAnchor.constraint(equalTo: anchor, constant: constant)
                anchoredConstraints.top?.priority = priority
            case .topGreaterThanOrEqualTo(let anchor, let constant, let priority):
                anchoredConstraints.top = topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
                anchoredConstraints.top?.priority = priority
            case .leading(let anchor, let constant, let priority):
                anchoredConstraints.leading = leadingAnchor.constraint(equalTo: anchor, constant: constant)
                anchoredConstraints.leading?.priority = priority
            case .leadingGreaterThanOrEqualTo(let anchor, let constant, let priority):
                anchoredConstraints.leading = leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
                anchoredConstraints.leading?.priority = priority
            case .bottom(let anchor, let constant, let priority):
                anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: anchor, constant: -constant)
                anchoredConstraints.bottom?.priority = priority
            case .bottomGreaterThanOrEqualTo(let anchor, let constant, let priority):
                anchoredConstraints.bottom = bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: -constant)
                anchoredConstraints.bottom?.priority = priority
            case .trailing(let anchor, let constant, let priority):
                anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: anchor, constant: -constant)
                anchoredConstraints.trailing?.priority = priority
            case .trailingGreaterThanOrEqualTo(let anchor, let constant, let priority):
                anchoredConstraints.trailing = trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: -constant)
                anchoredConstraints.trailing?.priority = priority
            case .heightConstant(let constant, let priority):
                if constant > 0 {
                    anchoredConstraints.height = heightAnchor.constraint(equalToConstant: constant)
                    anchoredConstraints.height?.priority = priority
                }
            case .height(let dimension, let multiplier, let priority):
                anchoredConstraints.height = heightAnchor.constraint(equalTo: dimension, multiplier: multiplier)
                anchoredConstraints.height?.priority = priority
            case .widthConstant(let constant, let priority):
                if constant > 0 {
                    anchoredConstraints.width = widthAnchor.constraint(equalToConstant: constant)
                    anchoredConstraints.width?.priority = priority
                }
            case .width(let dimension, let multiplier, let priority):
                anchoredConstraints.width = widthAnchor.constraint(equalTo: dimension, multiplier: multiplier)
                anchoredConstraints.width?.priority = priority
            }
        }
        [anchoredConstraints.top,
         anchoredConstraints.leading,
         anchoredConstraints.bottom,
         anchoredConstraints.trailing,
         anchoredConstraints.width,
         anchoredConstraints.height].forEach {
            $0?.isActive = true
        }
        return anchoredConstraints
    }
    
    @discardableResult
    public func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach { $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    @discardableResult
    public func fillSuperview(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        let anchoredConstraints = AnchoredConstraints()
        guard let superviewTopAnchor = superview?.topAnchor,
            let superviewBottomAnchor = superview?.bottomAnchor,
            let superviewLeadingAnchor = superview?.leadingAnchor,
            let superviewTrailingAnchor = superview?.trailingAnchor else {
                return anchoredConstraints
        }
        
        return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
    }
    
    @discardableResult
    public func fillSuperviewSafeAreaLayoutGuide(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
        let anchoredConstraints = AnchoredConstraints()
        guard let superviewTopAnchor = superview?.safeAreaLayoutGuide.topAnchor,
            let superviewBottomAnchor = superview?.safeAreaLayoutGuide.bottomAnchor,
            let superviewLeadingAnchor = superview?.safeAreaLayoutGuide.leadingAnchor,
            let superviewTrailingAnchor = superview?.safeAreaLayoutGuide.trailingAnchor else {
                return anchoredConstraints
        }
        return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
    }
    
    public func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    public func centerXTo(_ anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    
    public func centerYTo(_ anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    
    public func centerXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor, constant: constant).isActive = true
        }
    }
    
    public func centerYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor, constant: constant).isActive = true
        }
    }
    
    @discardableResult
    public func constrainHeight(_ constant: CGFloat, priority: UILayoutPriority = .required) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.height = heightAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.height?.priority = priority
        anchoredConstraints.height?.isActive = true
        return anchoredConstraints
    }
    
    @discardableResult
    public func constrainHeight(_ dimension: NSLayoutDimension,
                              multiplier: CGFloat = 1,
                              constant: CGFloat = 0,
                              priority: UILayoutPriority = .required) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.height = heightAnchor.constraint(equalTo: dimension,
                                                             multiplier: multiplier,
                                                             constant: constant)
        anchoredConstraints.height?.priority = priority
        anchoredConstraints.height?.isActive = true
        return anchoredConstraints
    }
    
    @discardableResult
    public func constrainHeightLessThanOrEqual(_ constant: CGFloat,
                                             priority: UILayoutPriority = .required) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.height = heightAnchor.constraint(lessThanOrEqualToConstant: constant)
        anchoredConstraints.height?.priority = priority
        anchoredConstraints.height?.isActive = true
        return anchoredConstraints
    }
    
    @discardableResult
    public func constrainHeightGreaterThanOrEqual(_ constant: CGFloat,
                                                priority: UILayoutPriority = .required) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.height = heightAnchor.constraint(greaterThanOrEqualToConstant: constant)
        anchoredConstraints.height?.priority = priority
        anchoredConstraints.height?.isActive = true
        return anchoredConstraints
    }
    
    @discardableResult
    public func constrainWidth(_ constant: CGFloat,
                             priority: UILayoutPriority = .required) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.width = widthAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.width?.priority = priority
        anchoredConstraints.width?.isActive = true
        return anchoredConstraints
    }
    
    @discardableResult
    public func constrainWidth(_ dimension: NSLayoutDimension,
                             multiplier: CGFloat = 1,
                             constant: CGFloat = 0,
                             priority: UILayoutPriority = .required) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.width = widthAnchor.constraint(equalTo: dimension,
                                                           multiplier: multiplier,
                                                           constant: constant)
        anchoredConstraints.width?.priority = priority
        anchoredConstraints.width?.isActive = true
        return anchoredConstraints
   }
    
    @discardableResult
    public func constrainWidthLessThanOrEqual(_ dimension: NSLayoutDimension,
                                            multiplier: CGFloat = 1,
                                            constant: CGFloat = 0,
                                            priority: UILayoutPriority = .required) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.width = widthAnchor.constraint(lessThanOrEqualTo: dimension,
                                                           multiplier: multiplier,
                                                           constant: constant)
        anchoredConstraints.width?.priority = priority
        anchoredConstraints.width?.isActive = true
        return anchoredConstraints
    }
    
    @discardableResult
    public func constrainWidthLessThanOrEqual(_ constant: CGFloat,
                                            priority: UILayoutPriority = .required) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.width = widthAnchor.constraint(lessThanOrEqualToConstant: constant)
        anchoredConstraints.width?.priority = priority
        anchoredConstraints.width?.isActive = true
        return anchoredConstraints
    }
    
    @discardableResult
    public func constrainWidthGreaterThanOrEqual(_ constant: CGFloat,
                                               priority: UILayoutPriority = .required) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.width = widthAnchor.constraint(greaterThanOrEqualToConstant: constant)
        anchoredConstraints.width?.priority = priority
        anchoredConstraints.width?.isActive = true
        return anchoredConstraints
    }
}
