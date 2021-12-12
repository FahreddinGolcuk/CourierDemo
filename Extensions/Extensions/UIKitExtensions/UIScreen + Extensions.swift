//
//  UIScreen + Extensions.swift
//  Extensions
//
//  Created by Fahreddin Gölcük on 11.12.2021.
//

import UIKit

public extension UIScreen {
    enum SizeType: CGFloat {
        case unknown = 0.0
        case iPhone4_5 = 640.0
        case iPhone6 = 750.0
        case iPhone6Plus = 1080.0
        case iPhoneXR = 828.0
        case iPhoneX = 1125.0
        case iPhoneXSMax = 1242.0
    }
    
    var sizeType: SizeType {
        let width = nativeBounds.width
        guard let sizeType = SizeType(rawValue: width) else { return .unknown }
        return sizeType
    }
}
