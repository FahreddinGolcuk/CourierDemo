//
//  PaymentView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.12.2021.
//

import Foundation
import UIKit
import Helpers

final class PaymentView: UIView {
    lazy var paymentText = with(UILabel()) {
        $0.text = "Payment"
    }
    
    init() {
        super.init(frame: .zero)
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PaymentView {
    func arrangeViews() {
        [
            paymentText
        ].forEach(addSubview)
        
        [
            paymentText.alignFitEdges()
        ]
        .flatMap { $0 }
        .activate()
    }
}
