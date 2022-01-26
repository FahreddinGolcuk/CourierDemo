//
//  PaymentItemViewModel.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 24.12.2021.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExtensions

struct PaymentItemViewModelInput {
    var viewDidLoad: Observable<Void> = .never()
    var productId: String = ""
    let productApi: ProductAPIClient = .live
    var increaseTap: Observable<Void> = .never()
    var decreaseTap: Observable<Void> = .never()
    var reloadEvent: Observable<Void> = .never()
}

struct PaymentItemViewModelOutput {
    let isLoading: Driver<Bool>
    let populate: Driver<Product>
    let increase: Driver<PaymentItemAmountViewDatasource>
    let decrease: Driver<PaymentItemAmountViewDatasource>
    let calculatePriceActions: Driver<Void>
}

typealias PaymentItemViewModel = (PaymentItemViewModelInput) -> PaymentItemViewModelOutput

func paymentItemViewModel(
    _ inputs: PaymentItemViewModelInput
) -> PaymentItemViewModelOutput {
    let activity = ActivityIndicator()
    
    let (responseProduct, _) = getProduct(inputs, activity: activity)
    let mergedActions = Observable.merge(inputs.increaseTap, inputs.decreaseTap)
        .asDriver(onErrorDriveWith: .never())
    
    return PaymentItemViewModelOutput(
        isLoading: activity.asDriver(onErrorDriveWith: .never()),
        populate: responseProduct,
        increase: increaseAmount(inputs),
        decrease: decreaseAmount(inputs),
        calculatePriceActions: mergedActions
    )
}

private func getProduct(
    _ input: PaymentItemViewModelInput,
    activity: ActivityIndicator
) -> (Driver<Product>, Driver<Error>) {
    Observable.of(input.viewDidLoad)
      .apiCall(activity) { _ -> Single<Product> in
          input.productApi.getProduct(input.productId)
      }
}

private func increaseAmount(
    _ inputs: PaymentItemViewModelInput
) -> Driver<PaymentItemAmountViewDatasource> {
    inputs.increaseTap
        .map {
            var leftButtonImage = "decreaseAmount"
            let quantity = Current.cartData.getBasketItemQuantity(with: inputs.productId)
            Current.cartData.setBasketInfo(with: BasketItemInfo(productId: inputs.productId, quantity: quantity + 1))
            if(quantity + 1 == 1) {
                leftButtonImage = "trash"
            }
            return PaymentItemAmountViewDatasource(leftButtonImage: leftButtonImage, quantity: quantity + 1)
        }
        .asDriver(onErrorDriveWith: .never())
}

private func decreaseAmount(
    _ inputs: PaymentItemViewModelInput
) -> Driver<PaymentItemAmountViewDatasource> {
    inputs.decreaseTap
        .map {
            let quantity = Current.cartData.getBasketItemQuantity(with: inputs.productId)
            var leftButtonImage = "decreaseAmount"
            if(quantity == 1 || quantity == 0) {
                Current.cartData.removeFromBasket(with: inputs.productId)
                return PaymentItemAmountViewDatasource(leftButtonImage: "decreaseAmount", quantity: 0)
            } else {
                Current.cartData.setBasketInfo(with: BasketItemInfo(productId: inputs.productId, quantity: quantity - 1))
                
                if(quantity - 1 == 1) {
                    leftButtonImage = "trash"
                }
                return PaymentItemAmountViewDatasource(leftButtonImage: leftButtonImage, quantity: quantity - 1)
            }
        }
        .asDriver(onErrorDriveWith: .never())
}
