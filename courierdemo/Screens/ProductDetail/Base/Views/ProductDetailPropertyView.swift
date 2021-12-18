//
//  ProductDetailPropertyView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 17.12.2021.
//

import Foundation
import UIKit
import Helpers
import Extensions

final class ProductDetailPropertyView: UIView {
    
    lazy var productCalorie = with(UILabel()){
        $0.textAlignment = .center
        $0.font = UIFont.Fonts.thinSmall
        $0.textColor = UIColor.Theme.primary
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.sizeToFit()
    }
    
    lazy var productEstimated = with(UILabel()){
        $0.text = "⏰ 10-15 min"
        $0.textAlignment = .center
        $0.font = UIFont.Fonts.thinSmall
        $0.textColor = UIColor.Theme.primary
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.sizeToFit()
    }
    
     lazy var productRating = with(UILabel()){
        $0.textAlignment = .center
        $0.font = UIFont.Fonts.thinSmall
        $0.textColor = UIColor.Theme.primary
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.sizeToFit()
    }
    lazy var stack = hStack(
        distribution: .fillEqually, space: 12
    )(
        productCalorie,
        productEstimated,
        productRating
    )
    
    init() {
        super.init(frame: .zero)
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProductDetailPropertyView {
    func arrangeViews() {
        addSubview(stack)
        stack.applyMargins(4)
        [
            stack.alignFitEdges()
        ]
        .flatMap { $0 }
        .activate()
    }
}
