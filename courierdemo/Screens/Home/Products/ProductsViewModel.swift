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
import Entities

struct ProductsViewModelInput {
    var viewDidLoad: Observable<Void> = .never()
    var productApi: ProductAPIClient = .live
}

struct ProductsViewModelOutput {
    let isLoading: Driver<Bool>
    let setHeight: Driver<Int>
    let setDatasource: Driver<[Product]>
}

typealias ProductsViewModel = (ProductsViewModelInput) -> ProductsViewModelOutput

func productsViewModel(
    _ inputs: ProductsViewModelInput
) -> ProductsViewModelOutput {
    let indicator = ActivityIndicator()
    
    let (response, _) =  inputs.viewDidLoad
        .apiCall(indicator) { _ -> Single<[Product]> in
            inputs.productApi.favoriteProducts()
        }
    
    return ProductsViewModelOutput(
        isLoading: indicator.asDriver(),
        setHeight: response.map { $0.count },
        setDatasource: response
    )
}
