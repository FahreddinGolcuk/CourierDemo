//
//  ProductItemAmountView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 18.12.2021.
//

import UIKit
import Extensions
import RxSwift

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
    
    //MARK: -Product list item cell
    init() {
        super.init(frame: .zero)
        addSubview(stack)
        rightButton.setImage(UIImage(named: "increaseAmount"), for: .normal)
        leftButton.setImage(UIImage(named: "trash"), for: .normal)
        stack.alignFitEdges().activate()
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Reactive where Base == ProductItemAmountView {
    var setLeftIcon: Binder<String> {
        Binder(base) { target, datasource in
            target.leftButton.setImage(UIImage(named: datasource), for: .normal)
        }
    }
}
