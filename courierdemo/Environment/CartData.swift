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
    
    var cartBadgeCount: Observable<UInt> {
        totalItemCount.asObservable()
    }
    
}
