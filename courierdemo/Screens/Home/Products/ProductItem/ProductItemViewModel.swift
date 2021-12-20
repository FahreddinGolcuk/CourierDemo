//
//  ProductItemViewModel.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 10.12.2021.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExtensions

struct ProductItemViewModelInput {
    var increaseButtonTapped: Observable<Void>
}

struct ProductItemViewModelOutput {
    let isLoading: Driver<Bool>
}

typealias ProductItemViewModel = (ProductItemViewModelInput) -> ProductItemViewModelOutput

func productItemViewModel(
    _ inputs: ProductItemViewModelInput
) -> ProductItemViewModelOutput {
    let activity = ActivityIndicator()
    _ = inputs.increaseButtonTapped
        .subscribe(onNext: {
            print("vmdentikladim")
        })
    return ProductItemViewModelOutput(
        isLoading: activity.asDriver()
    )
}
