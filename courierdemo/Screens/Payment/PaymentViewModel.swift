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
import Entities

struct PaymentViewModelInput {
    var viewDidLoad: Observable<Void> = .never()
    var reloadEvent: Observable<Void> = .never()
    var indexDeleted: Observable<IndexPath> = .never()
    var trashTapped: Observable<Void> = .never()
    var orderApi: OrderAPIClient = .live
}

struct PaymentViewModelOutput {
    let isLoading: Driver<Bool>
    let cartProductData: Driver<[BasketItemInfo]>
    let cartDeleted: Driver<Void>
    let cartRemoved: Driver<Void>
    let cartPriceAction: Driver<TotalPriceResponse>
}

typealias PaymentViewModel = (PaymentViewModelInput) -> PaymentViewModelOutput

func paymentViewModel(
    _ input: PaymentViewModelInput
) -> PaymentViewModelOutput {
    let activity = ActivityIndicator()
    let (response, _) = cartPriceAction(input, activity)
    
    return PaymentViewModelOutput(
        isLoading: activity.asDriver(onErrorDriveWith: .never()),
        cartProductData: cartProductData(input),
        cartDeleted: cartDeleted(input),
        cartRemoved: cartRemove(input),
        cartPriceAction: response
    )
}

func cartPriceAction(
    _ input: PaymentViewModelInput,
    _ activity: ActivityIndicator
) -> (Driver<TotalPriceResponse>, Driver<Error>) {
    input.reloadEvent
      .apiCall(activity) { _ -> Single<TotalPriceResponse> in
          let cart = Current.cartData.getBasketInfo
          var totalPriceRequest: [TotalPriceRequest] = []
          cart.forEach { item in
              totalPriceRequest.append(TotalPriceRequest(productId: item.productId, quantity: Int(item.quantity)))
          }
          print(totalPriceRequest)
          return input.orderApi.totalPrice(totalPriceRequest)
      }
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

func cartRemove(
    _ input: PaymentViewModelInput
) -> Driver<Void> {
    input.trashTapped
        .map { Current.cartData.removeBasketInfo() }
        .asDriver(onErrorDriveWith: .never())
}
