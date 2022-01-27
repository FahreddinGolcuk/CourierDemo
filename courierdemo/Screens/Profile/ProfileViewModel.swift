//
//  ProfileViewModel.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.12.2021.
//

import RxCocoa
import RxSwiftExtensions
import RxSwift

struct ProfileViewModelInput {
    var viewWillAppear: Observable<Void> = .never()
    var indexSelected: Observable<IndexPath> = .never()
}

struct ProfileViewModelOutput {
    var isLoading: Driver<Bool>
    let datasourceOutput: Driver<[ProfileSectionType]>
}

typealias ProfileViewModel = (ProfileViewModelInput) -> ProfileViewModelOutput

func profileViewModel(
    _ input: ProfileViewModelInput
) -> ProfileViewModelOutput {
    let activity = ActivityIndicator()
    return ProfileViewModelOutput(
        isLoading: activity.asDriver(onErrorDriveWith: .never()),
        datasourceOutput: getDatasource(input)
    )
}

// MARK: - Datasource Output
private func getDatasource(
    _ inputs: ProfileViewModelInput
) -> Driver<[ProfileSectionType]> {
    inputs.viewWillAppear
        .map { _ in ProfileSectionType.allCases }
        .asDriver(onErrorDriveWith: .never())
}
