//
//  Fonts.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 30.11.2021.
//

import Foundation
import UIKit

extension UIFont {
    struct Fonts {
        static var boldXLarge: UIFont  { return UIFont(name: "Avenir-Black", size: 30)! }
        static var boldLarge: UIFont  { return UIFont(name: "Avenir-Black", size: 24)! }
        static var boldMedium: UIFont  { return UIFont(name: "Avenir-Black", size: 20)! }
        static var boldSmall: UIFont  { return UIFont(name: "Avenir-Black", size: 16)! }
        static var boldVerySmall: UIFont  { return UIFont(name: "Avenir-Black", size: 12)! }
        
        static var thinXLarge: UIFont  { return UIFont(name: "Avenir-Light", size: 30)! }
        static var thinLarge: UIFont  { return UIFont(name: "Avenir-Light", size: 24)! }
        static var thinMedium: UIFont  { return UIFont(name: "Avenir-Light", size: 20)! }
        static var thinSmall: UIFont  { return UIFont(name: "Avenir-Light", size: 16)! }
        static var thinVerySmall: UIFont  { return UIFont(name: "Avenir-Light", size: 12)! }
    }
}
