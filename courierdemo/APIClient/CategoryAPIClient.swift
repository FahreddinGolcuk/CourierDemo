//
//  ProductAPIClient.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 17.12.2021.
//

import RxSwift
import Entities

private let baseURL =  "https://runningcourierapi.herokuapp.com/category/get-categories"

struct CategoryAPIClient {
    var categories: () -> Single<[CategoryItem]>
    
    init(
        categories: @escaping () -> Single<[CategoryItem]> = { .never() }
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
    static func categories() -> Single<[CategoryItem]> {
        return Single<[CategoryItem]>.create { observer -> Disposable in
            Request(with: baseURL, httpMethod: .get) { (result: Result<[CategoryItem], NetworkError>) in
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
