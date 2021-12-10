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
    
    private lazy var loginRegisterStackView = UIStackView.create(arrangedSubViews: [loginButton,registerButton],
                                                                  axis: .horizontal,
                                                                  distribution: .fillEqually,
                                                                  spacing: 16.0)
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .lightGray
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeView {
    func arrangeViews() {
        addSubview(nameLabel)
        nameLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.setSameInset(with: Constant.padding))
        
        addSubview(welcomeLabel)
        welcomeLabel.anchor(top: nameLabel.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.setSameInset(with: Constant.padding))
        
        addSubview(deliveryAddressLabel)
        deliveryAddressLabel.anchor(top: welcomeLabel.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.setSameInset(with: Constant.padding))
        
        addSubview(loginButton)
        loginButton.anchor(top: deliveryAddressLabel.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.setSameInset(with: Constant.padding), size: CGSize(width: screenWidth * 0.35, height: 60))
        
        addSubview(registerButton)
        registerButton.anchor(top: deliveryAddressLabel.bottomAnchor, leading: loginButton.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.setSameInset(with: Constant.padding), size: CGSize(width: screenWidth * 0.35, height: 60))
        
        addSubview(loginRegisterStackView)
        loginRegisterStackView.anchor(top: deliveryAddressLabel.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets.setSameInset(with: Constant.padding),size: CGSize(width: screenWidth, height: 70))
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
                         
