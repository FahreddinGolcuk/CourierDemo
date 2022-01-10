//
//  ProductAPIClient.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 17.12.2021.
//

import RxSwift
import struct Entities.Category

private let baseURL =  "https://runningcourierapi.herokuapp.com/"

fileprivate let getCategoriesURL: String = baseURL + "category/get-categories"

struct CategoryAPIClient {
    var categories: () -> Single<[Category]>
    
    init(
        categories: @escaping () -> Single<[Category]> = { .never() }
    ) {
        self.categories = categories
    }
}

extension CategoryAPIClient {
    static let live = Self(
        categories: categories
    )
}

private extension CategoryAPIClient {
    static func categories() -> Single<[Category]> {
        return Single<[Category]>.create { observer -> Disposable in
            Request(with: getCategoriesURL, httpMethod: .get) { (result: Result<[Category], NetworkError>) in
                switch result {
                case .success(let categories):
                    observer(.success(categories))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
