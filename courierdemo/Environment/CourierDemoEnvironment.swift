//
//  CourierDemoEnvironment.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 13.12.2021.
//

import Foundation
import RxSwift
import RxCocoa

var Current: Environment!

struct Environment {
    var userName = BehaviorRelay<String>(value: "")
    var userId = BehaviorRelay<String>(value: "")
    var email = BehaviorRelay<String>(value: "")
    var cartData = CartData()
}
