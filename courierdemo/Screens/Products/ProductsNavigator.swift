//
//  ProductsNavigation.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 17.12.2021.
//

import RxSwift
import RxCocoa

protocol ProductsNavigator {}

extension ProductsNavigator where Self: ProductsViewController {
    func showProductDetail(data: Product) {
        let controller = ProductDetailViewController(viewModel: productDetailViewModel, detailData: data)
        let navController = makeNavigationController(with: controller)
        navController.addCloseButtonToController(viewController: ProductDetailViewController(viewModel: productDetailViewModel, detailData: data))
        present(navController, animated: true, completion: nil)
    }
}
