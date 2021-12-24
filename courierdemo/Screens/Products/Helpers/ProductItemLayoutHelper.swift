//
//  ProductItemLayoutHelper.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 11.12.2021.
//

import CoreGraphics
import UIKit


struct ProductItemLayoutHelper {
    static let cellSpacing: CGFloat = 0
    static let horizontalCellHeight: CGFloat = 112.0
    static let imageWidthRatio: CGFloat = 3.03
    
    static func cellWidth(layoutAxis: NSLayoutConstraint.Axis) -> CGFloat {
        if case .horizontal = layoutAxis {
            let width = UIScreen.main.bounds.width / 1.72
            return min(width, 218.0)
        }
        let isIphone5 = UIScreen.main.sizeType == .iPhone4_5
        let cellCountAtRow: CGFloat = isIphone5 ? 2 : 3
        return (UIScreen.main.bounds.width - 20) / cellCountAtRow
    }
    
    static func cellHeight(layoutAxis: NSLayoutConstraint.Axis) -> CGFloat {
        if case .horizontal = layoutAxis {
            return horizontalCellHeight
        }
        return UIScreen.main.sizeType == .iPhone4_5
            ? 213.0
            : (cellWidth(layoutAxis: layoutAxis) * 1.6)
    }
    
    static func cellSize(layoutAxis: NSLayoutConstraint.Axis) -> CGSize {
        let width = cellWidth(layoutAxis: layoutAxis)
        let height = cellHeight(layoutAxis: layoutAxis)
        return CGSize(width: width, height: height)
    }
    
    static func titleWidth(_ layoutAxis: NSLayoutConstraint.Axis) -> CGFloat {
        let totalCellWidth = cellWidth(layoutAxis: layoutAxis)
        let layerWidth = totalCellWidth - 10.0
        var withConstrainedWidth: CGFloat = .zero
        if case .horizontal = layoutAxis {
            let imageWidth = layerWidth / imageWidthRatio
            withConstrainedWidth = layerWidth - (imageWidth + 35.0)
        } else {
            withConstrainedWidth = layerWidth - 16.0
        }
        return withConstrainedWidth
    }
}
