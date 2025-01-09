// 
//  UIImageView+SetImage.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//


import UIKit
import SDWebImage

public enum ImageLoadingIndicatorStyle {
    case gray
    case white
    
    fileprivate func toSDWebImageActivityIndicator() -> SDWebImageActivityIndicator {
        if self == .gray {
            return .gray
        } else {
            return .white
        }
    }
}

extension UIImageView {
    public func setImage(
        url stringURL: String?,
        placeholder: UIImage? = nil,
        loaderStyle: ImageLoadingIndicatorStyle = .gray,
        completion: ((UIImage?) -> Void)? = nil
    ) {
        guard let url = URL(string: stringURL ?? "") else {
            image = placeholder
            completion?(nil)
            return
        }
        
        setImage(
            url: url,
            placeholder: placeholder,
            loaderStyle: loaderStyle,
            completion: completion
        )
    }
    
    public func setImage(
        url: URL?,
        placeholder: UIImage? = nil,
        loaderStyle: ImageLoadingIndicatorStyle = .gray,
        completion: ((UIImage?) -> Void)? = nil
    ) {
        sd_imageIndicator = loaderStyle.toSDWebImageActivityIndicator()
        sd_setImage(with: url, placeholderImage: placeholder, completed: { image, _, _, _ in
            completion?(image)
        })
    }
}
