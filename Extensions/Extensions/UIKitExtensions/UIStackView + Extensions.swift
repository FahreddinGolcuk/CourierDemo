//
//  UIStackView + Extensions.swift
//  Extensions
//
//  Created by Fahreddin Gölcük on 2.12.2021.
//

import Foundation
import UIKit

public extension UIStackView {
    static func create(
        arrangedSubViews: [UIView] = [],
        axis: NSLayoutConstraint.Axis = .vertical,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = .leastNormalMagnitude,
        tamic: Bool = true
    ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = tamic
        return stackView
    }
    
    @discardableResult
    func applyMargins(_ margin: CGFloat) -> UIStackView {
        applyMargins(top: margin, leading: margin, bottom: margin, trailing: margin)
    }
    
    @discardableResult
    func applyMargins(
        top: CGFloat = .leastNormalMagnitude,
        leading: CGFloat = .leastNormalMagnitude,
        bottom: CGFloat = .leastNormalMagnitude,
        trailing: CGFloat = .leastNormalMagnitude
    ) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: top,
            leading: leading,
            bottom: bottom,
            trailing: trailing
        )
        return self
    }
    
}

public func vStack(
    distribution: UIStackView.Distribution = .fill,
    alignment: UIStackView.Alignment = .fill,
    space: CGFloat = 0,
    isBaselineRelativeArrangement: Bool = false,
    isLayoutMarginsRelativeArrangement: Bool = false
) -> (UIView...) -> UIStackView {
    { (views: UIView...) in
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.spacing = space
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.isBaselineRelativeArrangement = isBaselineRelativeArrangement
        stackView.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
        return stackView
    }
}

public func hStack(
    distribution: UIStackView.Distribution = .fill,
    alignment: UIStackView.Alignment = .fill,
    space: CGFloat = 0,
    isBaselineRelativeArrangement: Bool = false,
    isLayoutMarginsRelativeArrangement: Bool = false
) -> (UIView...) -> UIStackView {
    { (views: UIView...) in
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.spacing = space
        stackView.alignment = alignment
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.distribution = distribution
        stackView.isBaselineRelativeArrangement = isBaselineRelativeArrangement
        stackView.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
        return stackView
    }
}

