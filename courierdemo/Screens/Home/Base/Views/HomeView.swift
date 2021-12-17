//
//  HomeView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 18.11.2021.
//

import UIKit
import Helpers
import Extensions
import RxSwift

final class HomeView: UIView {
    
    let promotionView = PromotionView()
    
    let logoImageView = with(UIImageView()) {
        let logo = #imageLiteral(resourceName: "app-logo")
        $0.image = logo
        $0.contentMode = .scaleAspectFit
    }
    
    let nameLabel = with(UILabel()) {
        $0.font = UIFont.Fonts.boldSmall
        $0.textColor = UIColor.Theme.title
        $0.text = "Guest"
    }
    
    let welcomeLabel = with(UILabel()) {
        $0.text = "Welcome! 🥳"
        $0.font = UIFont.Fonts.boldXLarge
    }
    
    let deliveryAddressLabel =  with(UILabel()) {
        $0.text = "Delivery to 🏡"
        $0.font = UIFont.Fonts.boldLarge
    }
    
    let loginButton = with(UIButton()) {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.Theme.primary.cgColor
        $0.setTitle("Login", for: .normal)
        $0.setTitleColor(UIColor.Theme.primary, for: .normal)
        $0.sizeAnchor(height: 60)
    }
    
    let registerButton = with(UIButton()) {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.Theme.primary.cgColor
        $0.setTitle("Register", for: .normal)
        $0.setTitleColor(UIColor.Theme.primary, for: .normal)
        $0.sizeAnchor(height: 60)
    }
    
    let scrollView = with(UIScrollView(frame: .zero)) {
        $0.alwaysBounceVertical = true
    }
    
    let stackView = vStack(space: 8)()
    
    lazy var loginRegisterStackView = hStack(
        distribution: .fillEqually,
        space: 4
    )(
        loginButton,
        registerButton
    )
    
    init() {
        super.init(frame: .zero)
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeView {
    func arrangeViews() {
        stackView.applyMargins(8)
        
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        [
            nameLabel,
            welcomeLabel,
            promotionView,
            deliveryAddressLabel,
            loginRegisterStackView
        ].forEach(stackView.addArrangedSubview(_:))
        
        [
            scrollView.alignFitEdges(),
            stackView.alignFitEdges(),
            [
                stackView.alighWidth(screenWidth),
                promotionView.alignHeight(screenHeight * 0.15)
            ]
        ]
        .flatMap { $0 }
        .activate()
    }
}

extension Reactive where Base == HomeView {
    var isShowEntryStack: Binder<Bool> {
        Binder(base) { target, isShow in
            target.loginRegisterStackView.isHidden = !isShow
        }
    }
    
    var setNameLabel: Binder<String> {
        Binder(base) { target, title in
            target.nameLabel.text = title
        }
    }
}

private enum Constant {
    static let padding: CGFloat = 4
}                    
