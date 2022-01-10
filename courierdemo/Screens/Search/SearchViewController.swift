//
//  SearchViewController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 18.11.2021.
//

import UIKit
import RxSwift

class SearchViewController: UIViewController {
    private lazy var viewSource = SearchView()
    private let bag = DisposeBag()
    
    let selectedCategory = Observable<CategoryListDatasource>.pipe()
    
    
    override func loadView() {
        view = viewSource
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        addChildren()
    }
}

extension SearchViewController {
    func addChildren() {
        let categoryList: CategoryListViewController = {
            CategoryListViewController(
                viewModel: categoryListViewModel,
                selectedCategoryEvent: selectedCategory.observer
            )
        }()
        
        let products: ProductsViewController = {
            ProductsViewController(
                viewModel: productsViewModel,
                type: .normal,
                selectedCategory: selectedCategory.observable
            )
        }()
        
        let text = viewSource.searchBar.rx.text.orEmpty.asObservable()
        
        let controllers = [
            categoryList,
            products
        ]
        
        controllers.forEach {
            addChildController(controller: $0) {
                viewSource.stackView.addArrangedSubview($0)
            }
        }
    }
}
