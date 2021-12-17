//
//  ProductAPIClient.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 17.12.2021.
//

import RxSwift
import Entities

private let baseURL =  "https://runningcourierapi.herokuapp.com/product/favorites"

struct ProductAPIClient {
    var favoriteProducts: () -> Single<[Product]>
    
    init(
        favoriteProducts: @escaping () -> Single<[Product]> = { .never() }
    ) {
        self.favoriteProducts = favoriteProducts
    }
}

extension ProductAPIClient {
    static let live = Self(
        favoriteProducts: favoriteProducts
    )
}

private extension ProductAPIClient {
    static func favoriteProducts() -> Single<[Product]> {
        return Single<[Product]>.create { observer -> Disposable in
            Request(with: baseURL, httpMethod: .get) { (result: Result<[Product], NetworkError>) in
                switch result {
                case .success(let categories):
                    observer(.success(categories))
                case .failure(let error):
                    print(error)
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}

