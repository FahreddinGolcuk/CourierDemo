//
//  ProfileViewModel.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.12.2021.
//

import RxCocoa
import RxSwiftExtensions

struct ProfileViewModelInput {
    
}

struct ProfileViewModelOutput {
    var isLoading: Driver<Bool>
}

typealias ProfileViewModel = (ProfileViewModelInput) -> ProfileViewModelOutput

func profileViewModel(
    _ input: ProfileViewModelInput
) -> ProfileViewModelOutput {
    let activity = ActivityIndicator()
    return ProfileViewModelOutput(
        isLoading: activity.asDriver(onErrorDriveWith: .never())
    )
}
