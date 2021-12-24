//
//  SearchViewController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 18.11.2021.
//

import UIKit

class SearchViewController: UIViewController {
    private lazy var viewSource = SearchView()
    
    private lazy var bestProducts: ProductsViewController = {
        ProductsViewController(
            viewModel: productsViewModel
        )
    }()
    
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
        let controllers = [
            bestProducts
        ]
        controllers.forEach {
            addChildController(controller: $0) {
                viewSource.stackView.addArrangedSubview($0)
            }
        }
    }
}
