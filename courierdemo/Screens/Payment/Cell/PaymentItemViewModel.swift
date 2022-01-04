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
}

struct PaymentItemViewModelOutput {
    let isLoading: Driver<Bool>
    let populate: Driver<Product>
}

typealias PaymentItemViewModel = (PaymentItemViewModelInput) -> PaymentItemViewModelOutput

func paymentItemViewModel(
    _ inputs: PaymentItemViewModelInput
) -> PaymentItemViewModelOutput {
    let activity = ActivityIndicator()
    
    let (responseProduct, _) = getProduct(inputs, activity: activity)
    
    return PaymentItemViewModelOutput(
        isLoading: activity.asDriver(onErrorDriveWith: .never()),
        populate: responseProduct
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
