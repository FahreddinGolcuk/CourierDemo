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
    var decreaseButtonTapped: Observable<Void>
    var addProductButtonTapped: Observable<Void>
    var product: Product
}

struct ProductItemViewModelOutput {
    let isLoading: Driver<Bool>
    let increaseAmount: Driver<ProductItemEditViewDatasource>
    let decreaseAmount: Driver<ProductItemEditViewDatasource>
    let addTappedAmount: Driver<ProductItemEditViewDatasource>
}

typealias ProductItemViewModel = (ProductItemViewModelInput) -> ProductItemViewModelOutput

func productItemViewModel(
    _ inputs: ProductItemViewModelInput
) -> ProductItemViewModelOutput {
    let activity = ActivityIndicator()
    
    return ProductItemViewModelOutput(
        isLoading: activity.asDriver(),
        increaseAmount: increaseAmount(inputs),
        decreaseAmount: decreaseAmount(inputs),
        addTappedAmount: tappedAddProductButton(inputs)
    )
}

private func tappedAddProductButton(
    _ inputs: ProductItemViewModelInput
) -> Driver<ProductItemEditViewDatasource> {
    inputs.addProductButtonTapped
        .map {
            if(!Current.cartData.isBasketItem(with: inputs.product._id)) {
                Current.cartData.setBasketInfo(with: BasketItemInfo(productId: inputs.product._id, quantity: 1))
            }
            return ProductItemEditViewDatasource(leftButtonImage: "trash", quantity: 1, showEditView: true)
        }
        .asDriver(onErrorDriveWith: .never())
}

private func increaseAmount(
    _ inputs: ProductItemViewModelInput
) -> Driver<ProductItemEditViewDatasource> {
    inputs.increaseButtonTapped
        .map {
            var leftButtonImage = ""
            Current.cartData.setBasketInfo(with: BasketItemInfo(productId: inputs.product._id, quantity: Current.cartData.getBasketItemQuantity(with: inputs.product._id) + 1))
            if(Current.cartData.getBasketItemQuantity(with: inputs.product._id) == 1) {
                leftButtonImage = "trash"
            } else {leftButtonImage = "decreaseAmount"}
            return ProductItemEditViewDatasource(leftButtonImage: leftButtonImage, quantity: Current.cartData.getBasketItemQuantity(with: inputs.product._id), showEditView: true)
        }
        .asDriver(onErrorDriveWith: .never())
}

private func decreaseAmount(
    _ inputs: ProductItemViewModelInput
) -> Driver<ProductItemEditViewDatasource> {
    inputs.decreaseButtonTapped
        .map {
            var leftButtonImage = ""
            if(Current.cartData.getBasketItemQuantity(with: inputs.product._id) == 1) {
                Current.cartData.removeFromBasket(with: inputs.product._id)
                return ProductItemEditViewDatasource(leftButtonImage: "", quantity: 0, showEditView: false)
            } else {
                Current.cartData.setBasketInfo(with: BasketItemInfo(productId: inputs.product._id, quantity: Current.cartData.getBasketItemQuantity(with: inputs.product._id) - 1))
                
                if(Current.cartData.getBasketItemQuantity(with: inputs.product._id) == 1) {
                    leftButtonImage = "trash"
                } else {leftButtonImage = "decreaseAmount"}
                return ProductItemEditViewDatasource(leftButtonImage: leftButtonImage, quantity: Current.cartData.getBasketItemQuantity(with: inputs.product._id), showEditView: true)
            }
        }
        .asDriver(onErrorDriveWith: .never())
}
