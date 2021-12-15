//
//  CourierTabbarViewModel.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.12.2021.
//

import Foundation

import class RxSwift.Observable
import struct RxCocoa.Driver

// MARK: - IO
struct CourierTabbarViewModelInput {
    var viewDidLoad: Observable<Void> = .never()
    var cartBadgeCount: Observable<UInt> = .never()
}

struct CourierTabbarViewModelOutput {
    let cartBadgeCount: Driver<String?>
}

typealias CourierTabbarViewModel = (CourierTabbarViewModelInput) -> CourierTabbarViewModelOutput

// MARK: - IO Mapping
func courierTabbarViewModel(
    _ inputs: CourierTabbarViewModelInput
) -> CourierTabbarViewModelOutput {
    CourierTabbarViewModelOutput(
        cartBadgeCount: getCartBadgeCountOutput(inputs)
    )
}

// MARK: - Cart Badge Count Output
private func getCartBadgeCountOutput(
    _ inputs: CourierTabbarViewModelInput
) -> Driver<String?> {
    inputs.cartBadgeCount
        .map { $0 > 0 ? String($0) : Optional<String>.none }
        .distinctUntilChanged()
        .asDriver(onErrorDriveWith: .never())
}

