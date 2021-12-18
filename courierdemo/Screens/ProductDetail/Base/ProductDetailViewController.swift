//
//  ProductDetailViewController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 17.12.2021.
//

import UIKit
import RxSwift

class ProductDetailViewController: UIViewController {
    private var viewModel: ProductDetailViewModel
    private let viewSource = ProductDetailView()
    private let data: Product
    private let bag = DisposeBag()
    
    init(viewModel: @escaping ProductDetailViewModel, detailData: Product) {
        self.viewModel = viewModel
        self.data = detailData
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = viewSource
        populate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationController?.addCloseButtonToController(viewController: self)
        view.backgroundColor = .red
        super.viewDidLoad()
    }
}

private extension ProductDetailViewController {
    func bindViewModelOutput() {
        let output = viewModel(inputs)
    }
    var inputs: ProductDetailViewModelInput {
        return ProductDetailViewModelInput(
            viewDidLoad: .just(())
        )
    }
}

private extension ProductDetailViewController {
    func populate() {
        viewSource.populate(data: data)
    }
}
