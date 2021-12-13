//
//  UIView + Extensions.swift
//  Extensions
//
//  Created by Fahreddin Gölcük on 7.12.2021.
//

import Foundation
import UIKit

public extension UIView {
    func sizeAnchor(width: CGFloat? = nil, height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func anchor(top: (anchor: NSLayoutYAxisAnchor?, constant: CGFloat) = (nil, 0),
                leading: (anchor: NSLayoutXAxisAnchor?, constant: CGFloat) = (nil, 0),
                bottom: (anchor: NSLayoutYAxisAnchor?, constant: CGFloat) = (nil, 0),
                trailing: (anchor: NSLayoutXAxisAnchor?, constant: CGFloat) = (nil, 0)) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let toTopAnchor = top.anchor {
            topAnchor.constraint(equalTo: toTopAnchor, constant: top.constant).isActive = true
        }
        
        if let toLeadingAnchor = leading.anchor {
            leadingAnchor.constraint(equalTo: toLeadingAnchor, constant: leading.constant).isActive = true
        }
        
        if let toBottomAnchor = bottom.anchor {
            bottomAnchor.constraint(equalTo: toBottomAnchor, constant: -bottom.constant).isActive = true
        }
        
        if let toTrailingAnchor = trailing.anchor {
            trailingAnchor.constraint(equalTo: toTrailingAnchor, constant: -trailing.constant).isActive = true
        }
    }
    
    @discardableResult
    func alignFitEdges(insetedBy: CGFloat = .zero) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            leadingAnchor.constraint(
                equalTo: superview!.leadingAnchor,
                constant: insetedBy
            ),
            trailingAnchor.constraint(
                equalTo: superview!.trailingAnchor,
                constant: -insetedBy
            ),
            topAnchor.constraint(
                equalTo: superview!.topAnchor,
                constant: insetedBy
            ),
            bottomAnchor.constraint(
                equalTo: superview!.bottomAnchor,
                constant: -insetedBy
            )
        ]
        return constraints
    }
    
    @discardableResult
    func alignEdges(
        leading: CGFloat = .zero,
        trailing: CGFloat = .zero,
        top: CGFloat = .zero,
        bottom: CGFloat = .zero
    ) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            leadingAnchor.constraint(
                equalTo: superview!.leadingAnchor,
                constant: leading
            ),
            trailingAnchor.constraint(
                equalTo: superview!.trailingAnchor,
                constant: trailing
            ),
            topAnchor.constraint(
                equalTo: superview!.topAnchor,
                constant: top
            ),
            bottomAnchor.constraint(
                equalTo: superview!.bottomAnchor,
                constant: bottom
            )
        ]
        return constraints
    }
    
}

// MARK: - Align Directions
public extension UIView {
    @discardableResult
    func alignLeading(
        to view: UIView,
        offset: CGFloat = .zero
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let isSuperviewRelation = view == superview
        let anchor = isSuperviewRelation
            ? view.leadingAnchor
            : view.trailingAnchor
        
        let constraint = leadingAnchor.constraint(
            equalTo: anchor,
            constant: offset
        )
        return constraint
    }
    
    @discardableResult
    func alignTrailing(
        to view: UIView,
        offset: CGFloat = .zero
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let isSuperviewRelation = view == superview
        let anchor = isSuperviewRelation
            ? view.trailingAnchor
            : view.leadingAnchor
        
        let constraint = trailingAnchor.constraint(
            equalTo: anchor,
            constant: offset
        )
        return constraint
    }
    
    @discardableResult
    func alignTop(
        to view: UIView,
        offset: CGFloat = .zero
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let isSuperviewRelation = view == superview
        let anchor = isSuperviewRelation
            ? view.topAnchor
            : view.bottomAnchor
        
        let constraint = topAnchor.constraint(
            equalTo: anchor,
            constant: offset
        )
        return constraint
    }
    
    @discardableResult
    func alignBottom(
        to view: UIView,
        offset: CGFloat = .zero
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let isSuperviewRelation = view == superview
        let anchor = isSuperviewRelation
            ? view.bottomAnchor
            : view.topAnchor
        
        let constraint = bottomAnchor.constraint(
            equalTo: anchor,
            constant: offset
        )
        return constraint
    }
}

// MARK: - Sizing
public extension UIView {
    @discardableResult
    func alighWidth(_ constant: CGFloat) -> NSLayoutConstraint {
        sizeWith(widthAnchor, constant: constant)
    }
    
    @discardableResult
    func alignHeight(_ constant: CGFloat) -> NSLayoutConstraint {
        sizeWith(heightAnchor, constant: constant)
    }
    
    @discardableResult
    func alignSize(width: CGFloat, height: CGFloat) -> [NSLayoutConstraint] {
        let widthConstraint = sizeWith(widthAnchor, constant: width)
        let heightConstraint = sizeWith(heightAnchor, constant: height)
        let constraints = [widthConstraint, heightConstraint]
        return constraints
    }
    
    @discardableResult
    func equalWidth(
        with view: UIView,
        difference: CGFloat = .zero
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        return widthAnchor.constraint(
            equalTo: view.widthAnchor,
            constant: difference
        )
    }
    
    @discardableResult
    func equalHeight(
        with view: UIView,
        difference: CGFloat = .zero
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        return heightAnchor.constraint(
            equalTo: view.heightAnchor,
            constant: difference
        )
    }
}

// MARK: - Internal Workers
public extension UIView {
    func sizeWith(
        _ dimension: NSLayoutDimension,
        constant: CGFloat
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = dimension.constraint(
            equalToConstant: constant
        )
        return constraint
    }
    
    func centerXWith(
        _ referanceDimesion: NSLayoutXAxisAnchor,
        _ relationDimension: NSLayoutXAxisAnchor,
        constant: CGFloat
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = referanceDimesion.constraint(
            equalTo: relationDimension,
            constant: constant
        )
        return constraint
    }
    
    func centerYWith(
        _ referanceDimesion: NSLayoutYAxisAnchor,
        _ relationDimension: NSLayoutYAxisAnchor,
        constant: CGFloat
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = referanceDimesion.constraint(
            equalTo: relationDimension,
            constant: constant
        )
        return constraint
    }
}

// MARK: - Centering
public extension UIView {
    @discardableResult
    func center(in view: UIView, offset: CGPoint = .zero) -> [NSLayoutConstraint] {
        let centerXConstraint = centerXWith(
            centerXAnchor,
            view.centerXAnchor,
            constant: offset.x
        )
        let centerYConstraint = centerYWith(
            centerYAnchor,
            view.centerYAnchor,
            constant: offset.y
        )
        let constraints: [NSLayoutConstraint] = [
            centerXConstraint,
            centerYConstraint
        ]
        return constraints
    }
    
    @discardableResult
    func centerX(in view: UIView, offset: CGFloat = .zero) -> NSLayoutConstraint {
        let constraint = centerXWith(
            centerXAnchor,
            view.centerXAnchor,
            constant: offset
        )
        return constraint
    }
    
    @discardableResult
    func centerY(in view: UIView, offset: CGFloat = .zero) -> NSLayoutConstraint {
        let constraint = centerYWith(
            centerYAnchor,
            view.centerYAnchor,
            constant: offset
        )
        return constraint
    }
}


// MARK: - Activation
public extension Array where Element == NSLayoutConstraint {
    func activate() {
        NSLayoutConstraint.activate(self)
    }
}

public extension NSLayoutConstraint {
    func activate() {
        NSLayoutConstraint.activate([self])
    }
}
