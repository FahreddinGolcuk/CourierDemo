//
//  PaymentViewModel.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.12.2021.
//

import Foundation
import RxSwiftExtensions
import RxSwift
import RxCocoa

struct PaymentViewModelInput {
    var viewDidLoad: Observable<Void> = .never()
    var reloadEvent: Observable<Void> = .never()
    var indexDeleted: Observable<IndexPath> = .never()
}

struct PaymentViewModelOutput {
    let isLoading: Driver<Bool>
    let cartProductData: Driver<[BasketItemInfo]>
    let cartDeleted: Driver<Void>
}

typealias PaymentViewModel = (PaymentViewModelInput) -> PaymentViewModelOutput

func paymentViewModel(
    _ input: PaymentViewModelInput
) -> PaymentViewModelOutput {
    let activity = ActivityIndicator()
    
    return PaymentViewModelOutput(
        isLoading: activity.asDriver(onErrorDriveWith: .never()),
        cartProductData: cartProductData(input),
        cartDeleted: cartDeleted(input)
    )
}

func cartDeleted(
    _ input: PaymentViewModelInput
) -> Driver<Void> {
    input.indexDeleted
        .map { index in
            Current.cartData.removeFromBasket(with: Current.cartData.getBasketInfo[index.row].productId)
        }
        .asDriver(onErrorDriveWith: .never())
}

func cartProductData(
    _ input: PaymentViewModelInput
) -> Driver<[BasketItemInfo]> {
    Observable.merge(input.viewDidLoad, input.reloadEvent)
        .map { Current.cartData.getBasketInfo }
        .asDriver(onErrorDriveWith: .never())
}
