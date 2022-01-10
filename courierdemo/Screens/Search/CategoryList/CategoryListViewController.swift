//
//  CategoryListViewController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 5.01.2022.
//

import UIKit
import Helpers
import RxSwift
import struct Entities.Category
import RxCocoa

final class CategoryListViewController: UIViewController {
    fileprivate var selectedCategoryEvent: AnyObserver<CategoryListDatasource>
    
    let viewModel: CategoryListViewModel
    let bag = DisposeBag()
    fileprivate var categories: [Category] = []
    fileprivate var selectedIndex: UInt = 0
    
    private(set) lazy var viewSource = with(CategoryListView()) {
        $0.collectionView.dataSource = self
    }
    
    init(
        viewModel: @escaping CategoryListViewModel,
        selectedCategoryEvent: AnyObserver<CategoryListDatasource>
    ) {
        self.viewModel = viewModel
        self.selectedCategoryEvent = selectedCategoryEvent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func loadView() {
        view = viewSource
    }
    
}

extension CategoryListViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryListCollectionViewCell = collectionView.dequeue(at: indexPath)
        cell.populate.onNext(categories[indexPath.row])
        cell.isSelectedCategory.onNext(indexPath.row == selectedIndex)
        return cell
    }
}

extension CategoryListViewController {
    func bindViewModel() {
        let output = viewModel(input)
        bag.insert(
            output.datasource.drive(rx.setInfo),
            output.selectedCategory.drive(rx.selectedCategory)
        )
    }
    
    var input: CategoryListViewModelInput {
        let categorySelected = viewSource.collectionView.rx.itemSelected
            .asObservable()
            .observe(on: MainScheduler.asyncInstance)
        
        return CategoryListViewModelInput(
            viewDidLoad: .just(()),
            selectedCategory: categorySelected
        )
    }
}

extension Reactive where Base == CategoryListViewController {
    var setInfo: Binder<[Category]> {
        Binder(base) { target, datasource in
            target.categories = datasource
            target.viewSource.collectionView.reloadData()
            guard let firstData = datasource.first else { return }
            target.selectedCategoryEvent.onNext(CategoryListDatasource(index: 0, id: firstData._id))
        }
    }
    
    var selectedCategory: Binder<CategoryListDatasource> {
        Binder(base) { target, datasource in
            target.selectedIndex = datasource.index
            target.selectedCategoryEvent.onNext(datasource)
            target.viewSource.collectionView.reloadData()
        }
    }
}

