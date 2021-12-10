//
//  CourierDemoBuilder.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 8.12.2021.
//

import AppEnvironment
import UIKit

final public class CourierDemoBuilder {
    init() {
        configureEnvironment()
    }
}

extension CourierDemoBuilder {
    private func configureEnvironment() {
        
    }
}

public extension CourierDemoBuilder {
    func build() -> UIViewController? {
        let controller = CourierTabbarController()
        return controller
    }
}

public func setupAppEnvironment() {
    environment = AppEnvironment()
    environment.userName = "Fahoo"
    environment.email = "faho@"
}
