//
//  HomeViewModel.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 28.11.2021.
//

import Foundation
import RxCocoa
import RxSwift
import RxSwiftExtensions

struct HomeViewModelInput {
    var viewDidLoad: Observable<Void> = .never()
    var tappedLoginScreen: Observable<Void> = .never()
}

struct HomeViewModelOutput {
    let isLoading: Driver<Bool>
    let showLoginScreen: Driver<Void>
}

typealias HomeViewModel = (HomeViewModelInput) -> HomeViewModelOutput

func homeViewModel(input: HomeViewModelInput) -> HomeViewModelOutput {
    let activity = ActivityIndicator()
    return HomeViewModelOutput(
        isLoading: activity.asDriver(),
        showLoginScreen: tappedLoginButton(input)
    )
}

private func tappedLoginButton(
    _ inputs: HomeViewModelInput
) -> Driver<Void> {
    inputs.tappedLoginScreen
        .asDriver(onErrorDriveWith: .never())
}
