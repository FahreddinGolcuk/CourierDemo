//
//  UIEdgeInsets + Extensions.swift
//  Extensions
//
//  Created by Fahreddin Gölcük on 17.12.2021.
//

import Foundation
import UIKit

public extension UIEdgeInsets {
    static func setSameInset(with value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
}
     
