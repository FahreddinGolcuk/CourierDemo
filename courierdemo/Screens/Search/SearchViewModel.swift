//
//  SearchViewModel.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 7.01.2022.
//

import RxSwift
import RxCocoa
import RxSwiftExtensions

struct SearchViewModelInput {
    var viewDidLoad: Observable<Void>
}

struct SearchViewModelOutput {
    let isLoading: Driver<Bool>
}

typealias SearchViewModel = (SearchViewModelInput) -> SearchViewModelOutput

func searchViewModel(
    _ inputs: SearchViewModelInput
) -> SearchViewModelOutput {
    let indicator = ActivityIndicator()
    
    return SearchViewModelOutput(
        isLoading: indicator.asDriver()
    )
}
