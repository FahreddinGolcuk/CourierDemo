//
//  CategoryListViewModel.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 5.01.2022.
//

import Foundation
import RxSwift
import RxCocoa
import struct Entities.Category
import RxSwiftExtensions

struct CategoryListViewModelInput {
    var viewDidLoad: Observable<Void> = .never()
    var categoryApi: CategoryAPIClient = .live
    var selectedCategory: Observable<IndexPath> = .never()
}

struct CategoryListViewModelOutput {
    let datasource: Driver<[Category]>
    let selectedCategory: Driver<CategoryListDatasource>
}

typealias CategoryListViewModel = (CategoryListViewModelInput) -> CategoryListViewModelOutput

func categoryListViewModel(
    _ inputs: CategoryListViewModelInput
) -> CategoryListViewModelOutput {
    let activity = ActivityIndicator()
    
    let (categoryResponse, _) =
    inputs.viewDidLoad
        .apiCall(activity) { _ -> Single<[Category]> in
            inputs.categoryApi.categories()
    }
    
    return CategoryListViewModelOutput(
        datasource: categoryResponse,
        selectedCategory: selectedCategory( inputs, categoryResponse )
    )
}

private func selectedCategory(
    _ inputs: CategoryListViewModelInput,
    _ categories: Driver<[Category]>
) -> Driver<CategoryListDatasource> {
    inputs.selectedCategory
        .withLatestFrom(categories) { ($0,$1) }
        .map { CategoryListDatasource(index: UInt($0.0.row), id: $0.1[$0.0.row]._id)
        }
        .asDriver(onErrorDriveWith: .never())
}
