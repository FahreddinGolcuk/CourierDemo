//
//  UINavigationController + Extensions.swift
//  Extensions
//
//  Created by Fahreddin Gölcük on 7.12.2021.
//

import Foundation
import UIKit

public extension UINavigationController {
    func addCloseButtonToController(viewController: UIViewController, animated: Bool = false) {
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -5
        let closeButton = UIBarButtonItem.initWithSystemImage(imageName: "arrow.backward", target: self, action: #selector(UINavigationController.closeButtonAction))
        closeButton.tag = 3
        if var _ = viewController.navigationItem.leftBarButtonItems {
            guard !isCloseButtonAdded(viewController: viewController) else { return }
            if animated {
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                        viewController.navigationItem.setLeftBarButtonItems([closeButton], animated: true)
                    }, completion: nil)
                })
            } else {
                viewController.navigationItem.leftBarButtonItems?.insert(closeButton, at: 0)
            }
        } else {
            if #available(iOS 11, *) {
                viewController.navigationItem.setLeftBarButtonItems([closeButton], animated: animated)
            } else {
                viewController.navigationItem.setLeftBarButtonItems([negativeSpacer, closeButton], animated: animated)
            }
        }
    }
    
    @objc func closeButtonAction() {
        if let topController = viewControllers.last {
            topController.navigationBarCloseButtonWillDismiss()
        }
        if let nav = navigationController {
            nav.dismiss(animated: true, completion: {
                guard let topController = self.viewControllers.last else { return }
                topController.navigationBarCloseButtonDidDismiss()
            })
        } else {
            dismiss(animated: true, completion: {
                guard let topController = self.viewControllers.last else { return }
                topController.navigationBarCloseButtonDidDismiss()
            })
        }
    }
    
    fileprivate func isCloseButtonAdded(viewController: UIViewController) -> Bool {
        guard let items = viewController.navigationItem.leftBarButtonItems else { return false }
        return items.contains { $0.tag == 3 }
    }
}
