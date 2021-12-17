//
//  PromotionView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 16.12.2021.
//

import Foundation
import UIKit
import Helpers
import Extensions

final class PromotionView: UIView {
    let orderButtonForPromotion = with(UIButton()) {
        $0.backgroundColor = UIColor.Theme.primary
        $0.setTitle("Order Now", for: .normal)
        $0.setImage(UIImage(systemName: "cart"), for: .normal)
        $0.imageView?.tintColor = .white
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.titleLabel?.font = UIFont.Fonts.boldSmall
        $0.layer.shadowColor = UIColor.Theme.primary.cgColor
        $0.layer.shadowOffset = CGSize(width: 3.0, height: 4.0)
        $0.layer.shadowOpacity = 0.67
        $0.layer.shadowRadius = 7
        $0.layer.masksToBounds = false
    }
    
    let iconForPromotion = with(UIImageView()) {
        $0.image = UIImage(named: "delivery-sprite")
        $0.contentMode = .scaleAspectFit
    }
    
    let textForPromotion = with(UILabel()) {
        let attrs1 = [NSAttributedString.Key.font : UIFont.Fonts.thinMedium, NSAttributedString.Key.foregroundColor : UIColor.Theme.black]
        let attrs2 = [NSAttributedString.Key.font : UIFont.Fonts.boldMedium, NSAttributedString.Key.foregroundColor : UIColor.Theme.primary]
        let attributedString1 = NSMutableAttributedString(string:"Delivery feast via", attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:" Running Courier", attributes:attrs2)
        attributedString1.append(attributedString2)
        $0.attributedText = attributedString1
        $0.numberOfLines = 2
    }
    
    
    lazy var promotionVertical = vStack(space: 8
    )(
        textForPromotion,
        orderButtonForPromotion
    )
    
    lazy var promotionStackView = hStack(distribution: .equalCentering, space: 12, backgroundColor: UIColor.Theme.inactive, cornerRadius: 8
    )(
        promotionVertical,
        iconForPromotion
    )
    

    init() {
        super.init(frame: .zero)
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PromotionView {
    func arrangeViews() {
        addSubview(promotionStackView)
        promotionVertical.applyMargins(8)
        [
            promotionStackView.alignFitEdges(),
            [
                promotionVertical.alighWidth(screenWidth * 0.5)
            ]
        ]
        .flatMap{ $0 }
        .activate()
    }
}
