//
//  LoginView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 8.11.2021.
//

import UIKit
import RxSwift
import Extensions

final class LoginView: UIView {
    
    private(set) lazy var logoImageView: UIImageView = {
        let logo = #imageLiteral(resourceName: "app-logo")
        let logoImageView = UIImageView(image: logo)
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()
    
    private(set) lazy var emailInput: UITextField = {
        let emailInput = UITextField()
        emailInput.backgroundColor = .systemGray
        emailInput.placeholder = "E-mail"
        emailInput.layer.cornerRadius = 8
        emailInput.sizeAnchor(width: screenWidth * 0.6, height: 50)
        return emailInput
    }()
    
    private(set) lazy var passwordInput: UITextField = {
        let passwordInput = UITextField()
        passwordInput.isSecureTextEntry = true
        passwordInput.backgroundColor = .systemGray
        passwordInput.placeholder = "Password"
        passwordInput.layer.cornerRadius = 8
        passwordInput.sizeAnchor(width: screenWidth * 0.6, height: 50)
        return passwordInput
    }()
    
    private(set) lazy var loginButton: UIButton = {
        let loginButton: UIButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .orange
        loginButton.layer.cornerRadius = 8
        loginButton.sizeAnchor(width: screenWidth * 0.6, height: 80)
        return loginButton
    }()
    
    private(set) lazy var stack = vStack(space: 8)()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoginView {
    func arrangeViews() {
        addSubview(stack)
        [
            emailInput,
            passwordInput,
            loginButton
        ].forEach(stack.addArrangedSubview(_:))
        stack.applyMargins(8)
        [
            stack.alignTop(to: self),
            stack.alignLeading(to: self),
            stack.alignTrailing(to: self)
        ]
        .compactMap { $0 }
        .activate()
    }
}

extension Reactive where Base == LoginView {
    var verifyButton: Binder<Bool> {
        Binder(base) { target, isVerify in
            if isVerify {
                target.loginButton.backgroundColor = .blue
            } else {
                target.loginButton.backgroundColor = .systemRed
            }
        }
    }
}
