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
    var selectedCategory: Observable<CategoryListDatasource>
}

struct ProductItemViewModelOutput {
    let isLoading: Driver<Bool>
    let increaseAmount: Driver<ProductItemEditViewDatasource>
    let decreaseAmount: Driver<ProductItemEditViewDatasource>
    let addTappedAmount: Driver<ProductItemEditViewDatasource>
    let updateView: Driver<ProductItemEditViewDatasource>
    let changedSelectedCategory: Driver<Void>
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
        addTappedAmount: tappedAddProductButton(inputs),
        updateView: update(inputs),
        changedSelectedCategory: inputs.selectedCategory.map { _ in }.asDriver(onErrorDriveWith: .never())
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
            var leftButtonImage = "decreaseAmount"
            let quantity = Current.cartData.getBasketItemQuantity(with: inputs.product._id)
            Current.cartData.setBasketInfo(with: BasketItemInfo(productId: inputs.product._id, quantity: quantity + 1))
            if(quantity == 1) {
                leftButtonImage = "trash"
            }
            return ProductItemEditViewDatasource(leftButtonImage: leftButtonImage, quantity: quantity, showEditView: true)
        }
        .asDriver(onErrorDriveWith: .never())
}

private func decreaseAmount(
    _ inputs: ProductItemViewModelInput
) -> Driver<ProductItemEditViewDatasource> {
    inputs.decreaseButtonTapped
        .map {
            let quantity = Current.cartData.getBasketItemQuantity(with: inputs.product._id)
            var leftButtonImage = "decreaseAmount"
            if(quantity == 1) {
                Current.cartData.removeFromBasket(with: inputs.product._id)
                return ProductItemEditViewDatasource(leftButtonImage: "decreaseAmount", quantity: 0, showEditView: false)
            } else {
                Current.cartData.setBasketInfo(with: BasketItemInfo(productId: inputs.product._id, quantity: quantity - 1))
                
                if(quantity == 1) {
                    leftButtonImage = "trash"
                }
                return ProductItemEditViewDatasource(leftButtonImage: leftButtonImage, quantity: quantity, showEditView: true)
            }
        }
        .asDriver(onErrorDriveWith: .never())
}

func update(
    _ inputs: ProductItemViewModelInput
) -> Driver<ProductItemEditViewDatasource> {
    Observable.merge(inputs.increaseButtonTapped,inputs.decreaseButtonTapped,inputs.addProductButtonTapped)
        .debug("\(Current.cartData.getBasketItemQuantity(with: inputs.product._id ) ) \(inputs.product.name) ")
        .map {
            let quantity = Current.cartData.getBasketItemQuantity(with: inputs.product._id)
            return ProductItemEditViewDatasource(leftButtonImage: quantity == 1 ? "trash" : "decreaseAmount", quantity: quantity, showEditView: quantity > 0) }
        .asDriver(onErrorDriveWith: .never())
}
