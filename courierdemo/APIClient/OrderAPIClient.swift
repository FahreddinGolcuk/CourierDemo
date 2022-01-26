//
//  OrderAPIClient.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 26.01.2022.
//

import RxSwift
import struct Entities.TotalPriceRequest
import struct Entities.TotalPriceResponse

private let baseURL =  "https://runningcourierapi.herokuapp.com/"

fileprivate let getOrderPriceURL: String = baseURL + "order/cart-price"

struct OrderAPIClient {
    var totalPrice: ([TotalPriceRequest]) -> Single<TotalPriceResponse>
    
    init(
        totalPrice: @escaping ([TotalPriceRequest]) -> Single<TotalPriceResponse> = { _ in .never() }
    ) {
        self.totalPrice = totalPrice
    }
}

extension OrderAPIClient {
    static let live = Self(
        totalPrice: totalPrice
    )
}

private extension OrderAPIClient {
    static func totalPrice(_ cart: [TotalPriceRequest]) -> Single<TotalPriceResponse> {
        return Single<TotalPriceResponse>.create { observer -> Disposable in
            Request(with: getOrderPriceURL, httpMethod: .post, body: ["products": TotalPriceRequest.encode(input: cart) as Any]) { (result: Result<TotalPriceResponse, NetworkError>) in
                switch result {
                case .success(let totalPrice):
                    observer(.success(totalPrice))
                case .failure(let error):
                    print(error.localizedDescription)
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}

