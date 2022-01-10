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
    var productSelected: Observable<IndexPath> = .never()
    var productType: ProductTypes
    var selectedCategory: Observable<CategoryListDatasource>
}

struct ProductsViewModelOutput {
    let isLoading: Driver<Bool>
    let setHeight: Driver<Int>
    let setDatasource: Driver<[Product]>
    let showProductDetail: Driver<IndexPath>
}

typealias ProductsViewModel = (ProductsViewModelInput) -> ProductsViewModelOutput

func productsViewModel(
    _ inputs: ProductsViewModelInput
) -> ProductsViewModelOutput {
    let indicator = ActivityIndicator()
    
    let (response, _) =  inputs.productType == .favorite ? favoriteProducts(indicator, inputs) : selectedProducts(indicator, inputs)
    
    return ProductsViewModelOutput(
        isLoading: indicator.asDriver(),
        setHeight: response.map { $0.count },
        setDatasource: response,
        showProductDetail: inputs.productSelected.asDriver(onErrorDriveWith: .never())
    )
}

private func favoriteProducts(
    _ indicator: ActivityIndicator,
    _ inputs: ProductsViewModelInput
) -> (Driver<[Product]>, Driver<Error>) {
    inputs.viewDidLoad
       .apiCall(indicator) { _ -> Single<[Product]> in inputs.productApi.favoriteProducts()
   }
}

private func selectedProducts(
    _ indicator: ActivityIndicator,
    _ inputs: ProductsViewModelInput
) -> (Driver<[Product]>, Driver<Error>) {
    inputs.selectedCategory
        .withLatestFrom(inputs.viewDidLoad) { ($0,$1) }
            .apiCall(indicator) {
                inputs.productApi.getCategoryProducts($0.0.id)
            }
}
