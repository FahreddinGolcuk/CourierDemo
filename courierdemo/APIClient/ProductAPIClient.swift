//
//  ProductAPIClient.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 17.12.2021.
//

import RxSwift
import Entities

private let baseURL =  "https://runningcourierapi.herokuapp.com/"

fileprivate let favoriteProductURL: String = baseURL + "product/favorites"
fileprivate let getProductURL: String = baseURL + "product/getProduct"
fileprivate let getCategoryProductsURL: String = baseURL + "product/get-category-products"

struct ProductAPIClient {
    var favoriteProducts: () -> Single<[Product]>
    var getProduct: (_ productId: String) -> Single<Product>
    var getCategoryProducts: (_ categoryId: String) -> Single<[Product]>
    init(
        favoriteProducts: @escaping () -> Single<[Product]> = { .never() },
        getProduct: @escaping (_ productId: String) -> Single<Product> = { productId in .never() },
        getCategoryProducts: @escaping (_ categoryId: String) -> Single<[Product]> = { categoryId in .never() }
    ) {
        self.favoriteProducts = favoriteProducts
        self.getProduct = getProduct
        self.getCategoryProducts = getCategoryProducts
    }
}

extension ProductAPIClient {
    static let live = Self(
        favoriteProducts: favoriteProducts,
        getProduct: getProduct,
        getCategoryProducts: getCategoryProducts
    )
}

private extension ProductAPIClient {
    static func favoriteProducts() -> Single<[Product]> {
        return Single<[Product]>.create { observer -> Disposable in
            Request(with: favoriteProductURL, httpMethod: .get) { (result: Result<[Product], NetworkError>) in
                switch result {
                case .success(let products):
                    observer(.success(products))
                case .failure(let error):
                    print(error)
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    static func getProduct(_ productId: String) -> Single<Product> {
        return Single<Product>.create { observer -> Disposable in
            Request(with: getProductURL, httpMethod: .post, body: [
                "productId": productId
            ]) { (result: Result<Product, NetworkError>) in
                switch result {
                case .success(let product):
                    observer(.success(product))
                case .failure(let error):
                    print(error)
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    static func getCategoryProducts(_ categoryId: String) -> Single<[Product]> {
        return Single<[Product]>.create { observer -> Disposable in
            Request(with: getCategoryProductsURL, httpMethod: .get, urlParameter: "?id=" + categoryId) { (result: Result<[Product], NetworkError>) in
                switch result {
                case .success(let product):
                    observer(.success(product))
                case .failure(let error):
                    print(error)
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}

