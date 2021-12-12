//
//  LoginViewModel.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 8.11.2021.
//

import Foundation
import RxCocoa
import RxSwift
import RxSwiftExtensions
import AppEnvironment

struct LoginViewModelInput {
    var viewDidLoad: Observable<Void> = .never()
    var loginApi: LoginServiceProtocol
    var email: Observable<String> = .never()
    var password: Observable<String> = .never()
    var buttonTapped: Observable<Void> = .never()
    var environment = AppEnvironment()
}

struct LoginViewModelOutput {
    let isLoading: Driver<Bool>
    let buttonTitle: Driver<String>
    let verifyButton: Driver<Bool>
    let loginButtonTapped: Driver<[Category]>
}

typealias LoginViewModel = (LoginViewModelInput) -> LoginViewModelOutput

func loginViewModel(input: LoginViewModelInput) -> LoginViewModelOutput {
    let activity = ActivityIndicator()
        
    // MARK: - FavoriteProductList Response
    let (response, _) = Observable.merge(input.viewDidLoad.skip(1), input.buttonTapped)
        .apiCall(activity) { _ -> Single<[Category]> in
            input.loginApi.fetchCategory()
    }

    return LoginViewModelOutput(
        isLoading: activity.asDriver(),
        buttonTitle: buttonTitle(input.viewDidLoad),
        verifyButton: verifyButton(input.email, input.password),
        loginButtonTapped: response
    )
}

private func buttonTitle(
    _ viewDidLoad: Observable<Void>
) -> Driver<String> {
    let examp = false
    return viewDidLoad
        .debug()
        .map { examp ? "Deneme 1" : "Deneme 2"}
        .asDriver(onErrorDriveWith: .never())
}

private func verifyButton(
    _ email: Observable<String>,
    _ password: Observable<String>
) -> Driver<Bool> {
    Observable
        .combineLatest(email, password)
        .map { !$0.0.isEmpty && !$0.1.isEmpty }
        .asDriver(onErrorDriveWith: .never())
}

private func loginButtonApprove(
    _ inputs: LoginViewModelInput,
    _ indicator: ActivityIndicator,
    _ buttonTapped: Observable<Void>
) -> (Driver<[Category]>, Driver<Error>) {
    return buttonTapped
        .skip(1)
        .apiCall(indicator) { _ -> Single<[Category]> in
            inputs.loginApi.fetchCategory()
        }
}
