//
//  UINavigationBar.swift
//  Extensions
//
//  Created by Fahreddin Gölcük on 7.12.2021.
//

import Foundation
import UIKit

public extension UINavigationBar {
    func customize(
        bgColor: UIColor = .white,
        tintColor: UIColor = .darkGray,
        titleColor: UIColor = .darkGray
    ) {
        isTranslucent = false
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = bgColor
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
            standardAppearance = appearance
            scrollEdgeAppearance = appearance
        } else {
            backgroundColor = bgColor
            titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
        }
        barTintColor = bgColor
        self.tintColor = tintColor
    }
}
