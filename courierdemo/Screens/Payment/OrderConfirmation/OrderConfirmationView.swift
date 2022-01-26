//
//  OrderConfirmationView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 25.01.2022.
//

import UIKit
import Helpers
import Extensions

class OrderConfirmationView: UIView {
    private(set) lazy var title = with(UILabel()) {
        $0.text = "Order Confirmation"
        $0.font = UIFont.Fonts.boldMedium
    }
    
    private(set) lazy var adressTitle = with(UILabel()) {
        $0.text = "Delivery Adress"
        $0.font = UIFont.Fonts.boldSmall
    }
    
    
    private(set) lazy var creditCardTitle = with(UILabel()) {
        $0.text = "Credit Card"
        $0.textColor = .white
    }
    
    private(set) lazy var creditCardNumber = with(UILabel()) {
        $0.text = "5235 **** **** 2412"
        $0.textColor = .gray
    }
    
    private(set) lazy var creditCardVStack = vStack(
        distribution: .fillEqually,
        alignment: .leading,
        space: 2
    )(
        creditCardTitle,
        creditCardNumber
    )
    
    private let creditCardImage = with(UIImageView()) {
        $0.image = UIImage(named: "payment-mastercard")
        $0.contentMode = .scaleAspectFit
    }
    
    private(set) lazy var cardContentStack = hStack(
        space: 12,
        backgroundColor: .black,
        cornerRadius: 16
    )(
        creditCardImage,
        creditCardVStack
    )
    
    private(set) lazy var approveCartButton = with(UIButton(type: .custom)) {
        $0.setTitle("Confirm", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .semibold)
        $0.setContentHuggingPriority(
            .defaultLow,
            for: .horizontal
        )
        $0.layer.cornerRadius = 12
        $0.setContentCompressionResistancePriority(
            .defaultLow,
            for: .horizontal
        )
        $0.backgroundColor = .red
    }
    
    private(set) lazy var totalPriceTitle = with(UILabel()) {
        $0.text = "Total Price"
        $0.font = UIFont.Fonts.thinSmall
        $0.textColor = UIColor.Theme.title
    }
    
    private(set) lazy var totalPrice = with(UILabel()) {
        $0.text = "\(Current.cartData.getBasketInfo.count)"
        $0.font = UIFont.Fonts.thinMedium
    }
    
    private(set) lazy var totalPriceStack = vStack(
        space: 8
    )(
        totalPriceTitle,
        totalPrice
    )
    
    private(set) lazy var totalStack = hStack(
        space: 26
    )(
        totalPriceStack,
        approveCartButton
    )
    
    let stack = vStack(backgroundColor: .white)()
    
    init() {
        super.init(frame: .zero)
        addSubview(stack)
        [
            title,
            cardContentStack,
            adressTitle,
            totalStack
        ].forEach(stack.addArrangedSubview(_:))
        
        stack.applyMargins(8)
        [
            stack.alignFitEdges(),
            [
                cardContentStack.alignHeight(screenHeight * 0.1),
                creditCardImage.alighWidth(screenWidth * 0.1)
            ],
            [
                approveCartButton.alignHeight(50)
            ]
        ]
        .flatMap { $0 }
        .activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
