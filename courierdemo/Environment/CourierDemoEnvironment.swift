//
//  CourierDemoEnvironment.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 13.12.2021.
//

import Foundation

var Current: Environment!

struct Environment {
    var userName: String = ""
    var email: String = ""
    var cartData = CartData()
}
