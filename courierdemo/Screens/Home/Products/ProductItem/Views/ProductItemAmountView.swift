//
//  ProductItemAmountView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 18.12.2021.
//

import UIKit
import Extensions

class ProductItemAmountView: UIView {
    let leftButton = MarketProductAmountViewGenerator.createActionButton()
    let quantityLabel = MarketProductAmountViewGenerator.createQuantityLabel()
    let rightButton = MarketProductAmountViewGenerator.createActionButton()
    
    private lazy var stack = hStack(
        distribution: .fillEqually
    )(
        leftButton,
        quantityLabel,
        rightButton
    )
    
    init() {
        super.init(frame: .zero)
        addSubview(stack)
        leftButton.setImage(UIImage(named: "decreaseAmount"), for: .normal)
        rightButton.setImage(UIImage(named: "increaseAmount"), for: .normal)
        quantityLabel.text = "1"
        stack.alignFitEdges().activate()
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
