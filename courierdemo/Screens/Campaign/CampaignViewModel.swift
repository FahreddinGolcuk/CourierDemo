//
//  CampaignViewModel.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.12.2021.
//

import Foundation
import RxSwiftExtensions
import RxSwift
import RxCocoa

struct CampaignViewModelInput {
    let viewDidLoad: Observable<Void> = .never()
}

struct CampaignViewModelOutput {
    var isLoading: Driver<Bool>
}

typealias CampaignViewModel = (CampaignViewModelInput) -> CampaignViewModelOutput

func campaignViewModel(
    _ input: CampaignViewModelInput
) -> CampaignViewModelOutput {
    let activity = ActivityIndicator()
    return CampaignViewModelOutput(
        isLoading: activity.asDriver(onErrorDriveWith: .never())
    )
}
