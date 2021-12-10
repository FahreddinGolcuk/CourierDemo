//
//  LoginApi.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 9.11.2021.
//

import Foundation
import RxSwift

public protocol LoginServiceProtocol {
    func fetchCategory() -> Single<[Category]>
}

final class LoginService: LoginServiceProtocol {
    private let fetchUserUrl = "https://runningcourierapi.herokuapp.com/category/get-categories"
    
    public func fetchCategory() -> Single<[Category]> {
        return Single<[Category]>.create { observer -> Disposable in
            Request(with: self.fetchUserUrl) { (result: Result<[Category], NetworkError>) in
                switch result {
                case .success(let users):
                    observer(.success(users))
                    print(users)
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    public init() {}
    
}
