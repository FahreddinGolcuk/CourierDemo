//
//  ProductDetailViewModel.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 17.12.2021.
//

import Foundation
import RxSwiftExtensions
import RxSwift
import RxCocoa

struct ProductDetailViewModelInput {
    var viewDidLoad: Observable<Void> = .never()
}

struct ProductDetailViewModelOutput {
    let isLoading: Driver<Bool>
}

typealias ProductDetailViewModel = (ProductDetailViewModelInput) -> ProductDetailViewModelOutput

func productDetailViewModel(_ input: ProductDetailViewModelInput) -> ProductDetailViewModelOutput {
    let activity = ActivityIndicator()
    
    return ProductDetailViewModelOutput(
        isLoading: activity.asDriver()
    )
}
