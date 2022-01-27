//
//  BasketEmptyView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.01.2022.
//

import UIKit
import Helpers
import Extensions
final class BasketEmptyView: UIView {
    
    let image = with(UIImageView()) {
        $0.image = UIImage(named: "app-logo")
        $0.contentMode = .scaleAspectFit
    }
    
    let title = with(UILabel()) {
        $0.text = "Your basket is empty"
        $0.font = UIFont.Fonts.thinLarge
        $0.textColor = UIColor.Theme.title
    }
    
    lazy var stack = vStack(
        alignment: .center,
        backgroundColor: .white
    )(
        image,
        title
    )
    
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
        addSubview(stack)
        [
            stack.alignEdges(leading: 26, trailing: -26, top: 0, bottom: 0),
            [
                image.alignHeight(screenHeight * 0.2)
            ]
        ]
        .flatMap { $0 }
        .activate()
        backgroundColor = .white
    }
}
