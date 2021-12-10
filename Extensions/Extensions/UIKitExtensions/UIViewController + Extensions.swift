//
//  UIViewController + Extensions.swift
//  Extensions
//
//  Created by Fahreddin Gölcük on 7.12.2021.
//

import Foundation
import UIKit

// MARK: - UINavigationController
public extension UIViewController {

    func makeNavigationController(with rootController: UIViewController, fullScreen: Bool = true) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootController)
        navController.navigationBar.customize()
        if fullScreen {
            navController.modalPresentationStyle = .fullScreen
        }
        return navController
    }
    
    @objc func navigationBarCloseButtonWillDismiss() {}
    @objc func navigationBarCloseButtonDidDismiss() {}
}
