//
//  HomeView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 18.11.2021.
//

import UIKit
import Helpers
import Extensions

final class HomeView: UIView {
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
    
    let stackView = vStack(space: 0)()
    
    lazy var loginRegisterStackView = UIStackView.create(arrangedSubViews: [loginButton,registerButton],
                                                                  axis: .horizontal,
                                                                  distribution: .fillEqually,
                                                                  spacing: 16.0)
    
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
        [
            scrollView,
        ].forEach(addSubview)
        
        scrollView.addSubview(stackView)
        [
            nameLabel,
            welcomeLabel,
            deliveryAddressLabel,
            loginRegisterStackView
        ].forEach(stackView.addArrangedSubview(_:))
        
        stackView.addArrangedSubview(nameLabel)
        [
            scrollView.alignFitEdges(),
            stackView.alignFitEdges(),
            [
                stackView.alighWidth(UIScreen.main.bounds.size.width)
            ]
        ]
        .flatMap { $0 }
        .activate()
    }
}

private enum Constant {
    static let padding: CGFloat = 4
}

extension UIEdgeInsets {
    static func setSameInset(with value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
}
                         
