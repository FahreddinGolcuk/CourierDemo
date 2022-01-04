//
//  CartData.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 13.12.2021.
//

import Foundation
import RxSwift
import RxCocoa

struct CartData {
    private let totalItemCount = BehaviorRelay<UInt>(value: 0)
    private let basketInfo = BehaviorRelay<[String: UInt]>(value: [:])
    
    var cartBadgeCount: Observable<UInt> {
        totalItemCount.asObservable()
    }
    
    var getBasketInfo: [BasketItemInfo] {
        basketInfo.value.map { BasketItemInfo(productId: $0.key, quantity: $0.value) }
    }
    
    var cartBadgeCountValue: UInt {
        totalItemCount.value
    }
    
    func updateBadgeCount(with count: UInt) {
        totalItemCount.accept(count)
    }
    
    func setBasketInfo(with info: BasketItemInfo) {
        var basketDict = basketInfo.value
        basketDict[info.productId] = info.quantity
        basketInfo.accept(basketDict)
        totalItemCount.accept(UInt(basketInfo.value.count))
    }
    
    func removeFromBasket(with productId: String) {
        var basketDict = basketInfo.value
        basketDict[productId] = nil
        basketInfo.accept(basketDict)
        totalItemCount.accept(UInt(basketInfo.value.count))
    }
    
    func isBasketItem(with productId: String) -> Bool {
        basketInfo.value[productId] != nil
    }
    
    func getBasketItemQuantity(with productId: String) -> UInt {
        basketInfo.value[productId] ?? 0
    }
    
}
