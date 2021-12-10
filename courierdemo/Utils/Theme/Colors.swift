//
//  Colors.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 30.11.2021.
//

import Foundation
import UIKit

extension UIColor {
  struct Theme {
    static var primary: UIColor  { return UIColor(red: 0.83, green: 0.36, blue: 0.36, alpha: 1.00) }
    static var secondary: UIColor { return  UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00) }
    static var third: UIColor { return UIColor(red: 0.86, green: 0.59, blue: 0.43, alpha: 1.00) }
    static var fourth: UIColor { return UIColor(red: 0, green: 1, blue: 0, alpha: 1) }
    static var header: UIColor { return UIColor(red: 0.24, green: 0.24, blue: 0.25, alpha: 1.00)}
    static var title: UIColor { return UIColor(red: 0.38, green: 0.38, blue: 0.40, alpha: 1.00) }
    static var bg1: UIColor { return UIColor(red: 0.92, green: 0.89, blue: 0.79, alpha: 1.00) }
    static var bg2: UIColor { return UIColor(red: 0.86, green: 0.85, blue: 1.00, alpha: 1.00) }
    static var bg3: UIColor { return UIColor(red: 1.00, green: 0.85, blue: 0.90, alpha: 1.00) }
    static var inactive: UIColor { return UIColor(red: 1.00, green: 0.91, blue: 0.79, alpha: 1.00) }
    static var black: UIColor { return UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00) }
    static var lightGrey: UIColor { return UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00) }
  }
}
