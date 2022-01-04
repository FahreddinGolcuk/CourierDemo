//
//  LoginViewController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 8.11.2021.
//

import UIKit
import RxSwift
import RxCocoa
import Extensions
import Entities

final class LoginViewController: UIViewController {
    private let loginApi: LoginServiceProtocol
    var viewSource: LoginView  = LoginView()
    
    private(set) lazy var bag = DisposeBag()
    
    private let viewModel: LoginViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.addCloseButtonToController(viewController: self)
        view.backgroundColor = .blue
        print(88999 ,Current.userName, Current.email)
        arrangeViews()
        configureNavigationBar()
        bindViewModel()
    }
    
    override func loadView() {
        view = viewSource
    }
    
    init(
        loginApi: LoginServiceProtocol,
        viewModel: @escaping LoginViewModel
    ) {
        self.viewModel = viewModel
        self.loginApi = loginApi
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension LoginViewController {
    
    private func bindViewModel() {
        let output = viewModel(input)
        bag.insert(
            output.verifyButton.drive(viewSource.rx.verifyButton),
            output.loginButtonTapped.drive(rx.loginButtonTapped),
            output.isLoading.drive(rx.showLoading)
        )
    }
    
    
    private var input: LoginViewModelInput {
        let email = viewSource.emailInput.rx.text.orEmpty.asObservable()
        let password = viewSource.passwordInput.rx.text.orEmpty.asObservable()
        let buttonTapped = viewSource.loginButton.rx.tap.asObservable()
        
        return LoginViewModelInput(
            viewDidLoad: .just(()),
            loginApi: loginApi,
            email: email,
            password: password,
            buttonTapped: buttonTapped
        )
    }

    func arrangeViews() {
        title = "Login"
        view.backgroundColor = .blue
    }

    private func configureNavigationBar() {
        navigationItem.titleView = viewSource.logoImageView
    }
}
 
extension Reactive where Base == LoginViewController {
    var loginButtonTapped: Binder<UserResponse> {
        Binder(base) { target, item in
            target.view.backgroundColor = .gray
            print("Tikladim",item)
        }
    }
}
