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

    func addChildController<T: UIViewController>(
        controller: T,
        viewHandler: ((UIView) -> Void)
    ) {
        
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.frame = self.view.bounds
        viewHandler(controller.view)
        controller.didMove(toParent: self)
    }
    
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
