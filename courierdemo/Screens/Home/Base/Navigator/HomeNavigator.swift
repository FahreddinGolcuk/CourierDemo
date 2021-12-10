//
//  HomeNavigator.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 19.11.2021.
//

import Foundation
import Extensions

protocol HomeNavigator {}

extension HomeNavigator where Self: HomeViewController {
    func showLoginScreen() {
        let controller = LoginViewController(loginApi: LoginService(), viewModel: loginViewModel)
        let navController = makeNavigationController(with: controller)
        navController.addCloseButtonToController(viewController: LoginViewController(loginApi: LoginService(), viewModel: loginViewModel))
        present(navController, animated: true, completion: nil)
    }
}
