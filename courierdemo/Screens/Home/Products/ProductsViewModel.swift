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
}

typealias ProductsViewModel = (ProductsViewModelInput) -> ProductsViewModelOutput

func productsViewModel(
    _ inputs: ProductsViewModelInput
) -> ProductsViewModelOutput {
    let indicator = ActivityIndicator()
    return ProductsViewModelOutput(
        isLoading: indicator.asDriver()
    )
}
