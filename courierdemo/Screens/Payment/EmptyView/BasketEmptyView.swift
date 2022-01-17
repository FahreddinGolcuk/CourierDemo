//
//  BasketEmptyView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.01.2022.
//

import UIKit
import Helpers
final class BasketEmptyView: UIView {
    let title = with(UILabel()) {
        $0.text = "Sepetiniz boş"
        $0.textColor = .red
    }
    
    init() {
        super.init(frame: .zero)
        arrangeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BasketEmptyView {
    func arrangeView() {
        addSubview(title)
        [
            title.alignFitEdges()
        ]
        .flatMap { $0 }
        .activate()
    }
}
