//
//  LoginApi.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 9.11.2021.
//

import Foundation
import RxSwift
import Entities

public protocol LoginServiceProtocol {
    func login(credential: LoginRequest) -> Single<UserResponse>
}

final class LoginService: LoginServiceProtocol {
    private let loginUrl = "https://runningcourierapi.herokuapp.com/user/login"
    
    public func login(credential: LoginRequest) -> Single<UserResponse> {
        return Single<UserResponse>.create { observer -> Disposable in
            Request(with: self.loginUrl, httpMethod: .post, body: [
                "email": credential.email,
                "password": credential.password
            ]) { (result: Result<UserResponse, NetworkError>) in
                switch result {
                case .success(let user):
                    observer(.success(user))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    public init() {}
    
}
