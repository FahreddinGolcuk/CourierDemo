//
//  UIBarButtonItem + Extensions.swift
//  Extensions
//
//  Created by Fahreddin Gölcük on 7.12.2021.
//

import Foundation
import UIKit

public extension UIBarButtonItem {
    class func initWithImage(imageName: String, target: AnyObject, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(named: imageName), style: .plain, target: target, action: action)
    }
    
    class func initWithSystemImage(imageName: String, target: AnyObject, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(systemName: imageName), style: .plain, target: target, action: action)
    }
    
    class func initWithTitle(title: String, titleFont: UIFont, target: AnyObject, action: Selector?) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem.init(title: title, style: .plain, target: target, action: action)
        barButtonItem.setTitleTextAttributes([NSAttributedString.Key.font: titleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        return barButtonItem
    }
}
