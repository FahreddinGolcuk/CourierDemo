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
    func configureEnvironment() {
        Current = Environment()
    }
}

public extension CourierDemoBuilder {
    func build() -> UIViewController? {
        let controller = CourierTabbarController()
        return controller
    }
}

