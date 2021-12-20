//
//  BasketItemInfoItem.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 19.12.2021.
//

import Foundation

struct BasketItemInfo {
    let productId: String
    let quantity: UInt
    public init(
        productId: String,
        quantity: UInt
    ) {
        self.productId = productId
        self.quantity = quantity
    }
}
