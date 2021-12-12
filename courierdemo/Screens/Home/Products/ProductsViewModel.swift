//
//  ProductsViewModel.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 10.12.2021.
//

import Foundation
import RxSwiftExtensions
import RxSwift
import RxCocoa

struct ProductsViewModelInput {
    
}

struct ProductsViewModelOutput {
    let isLoading: Driver<Bool>
    let setHeight: Driver<Int>
}

typealias ProductsViewModel = (ProductsViewModelInput) -> ProductsViewModelOutput

func productsViewModel(
    _ inputs: ProductsViewModelInput
) -> ProductsViewModelOutput {
    let indicator = ActivityIndicator()
    return ProductsViewModelOutput(
        isLoading: indicator.asDriver(),
        setHeight: getItemCounts(inputs)
    )
}

func getItemCounts(
    _ inputs: ProductsViewModelInput
) -> Driver<Int> {
    let counts = BehaviorRelay(value: 0)
    counts.accept(mockProducts.count)
    return counts.asDriver()
}

