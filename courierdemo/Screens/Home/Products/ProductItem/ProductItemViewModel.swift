//
//  ProductItemViewModel.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 10.12.2021.
//

import Foundation
import RxCocoa
import RxSwiftExtensions

struct ProductItemViewModelInput {
    
}

struct ProductItemViewModelOutput {
    let isLoading: Driver<Bool>
}

typealias ProductItemViewModel = (ProductItemViewModelInput) -> ProductItemViewModelOutput

func productItemViewModel(
    _ inputs: ProductItemViewModelInput
) -> ProductItemViewModelOutput {
    let activity = ActivityIndicator()
    return ProductItemViewModelOutput(
        isLoading: activity.asDriver()
    )
}
