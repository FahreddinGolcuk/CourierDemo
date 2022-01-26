//
//  ProductAmountViewGenerator.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 18.12.2021.
//

import func Helpers.with
import UIKit

struct MarketProductAmountViewGenerator {
    static func createActionButton() -> UIButton {
        with(UIButton(type: .custom)) {
            $0.isOpaque = true
            $0.backgroundColor = .white
            $0.translatesAutoresizingMaskIntoConstraints = false
            if UIAccessibility.isVoiceOverRunning {
                $0.isAccessibilityElement = true
                $0.accessibilityTraits = .button
            }
        }
    }
    
    static func createQuantityLabel() -> UILabel {
        with(UILabel()) {
            $0.textAlignment = .center
            $0.textColor = .black
            $0.text = "1"
            $0.font = .boldSystemFont(ofSize: 14.0)
            $0.isOpaque = true
            $0.backgroundColor = UIColor.Theme.inactive
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.isAccessibilityElement = true
        }
    }
}

