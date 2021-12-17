//
//  ProductsViewController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 10.12.2021.
//

import Foundation
import UIKit
import RxSwift
import func Helpers.with

final class ProductsViewController: UIViewController {
    let bag = DisposeBag()
    private let viewModel: ProductsViewModel
    fileprivate var productList: [Product] = []
    
    private(set) lazy var viewSource = with(ProductsView()) {
        $0.collectionView.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModelOutput()
    }
    
    override func loadView() {
        view = viewSource
    }

    init(viewModel: @escaping ProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProductsViewController {
    func bindViewModelOutput() {
        let outputs = viewModel(inputs)
        
        bag.insert(
            outputs.setHeight.drive(viewSource.rx.setHeight),
            outputs.setDatasource.drive(rx.setDataSource)
        )
    }
    
    var inputs: ProductsViewModelInput {
        let productSelected = viewSource.collectionView.rx.itemSelected
            .asObservable()
            .observe(on: MainScheduler.asyncInstance)
        
        return ProductsViewModelInput(
            viewDidLoad: .just(()),
            productSelected: productSelected
        )
    }
}

extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductItemCell = collectionView.dequeue(at: indexPath)
        cell.populate.onNext(productList[indexPath.row])
        return cell
    }
}

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        ProductItemLayoutHelper.cellSize(layoutAxis: .vertical)
    }
}

private extension Reactive where Base == ProductsViewController {
    var setDataSource: Binder<[Product]> {
        Binder(base) { target, datasource in
            target.productList = datasource
            target.viewSource.collectionView.reloadData()
        }
    }
}
