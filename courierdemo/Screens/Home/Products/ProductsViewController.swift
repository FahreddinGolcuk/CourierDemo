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
    fileprivate var productList: [Product] = mockProducts
    
    private(set) lazy var viewSource = with(ProductsView()) {
        $0.collectionView.dataSource = self
    }
    private let isIphone5SizeWidth = UIScreen.main.sizeType == .iPhone4_5
    private let itemSpacing: CGFloat = 15.0

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
            outputs.setHeight.drive(viewSource.rx.setHeight)
        )
    }
    
    var inputs: ProductsViewModelInput {
        return ProductsViewModelInput()
    }
}

extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductItemCell = collectionView.dequeue(at: indexPath)
        print(cell.viewIdentifier)
        return cell
    }
}

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        ProductItemLayoutHelper.cellSize(layoutAxis: .vertical)
    }
}

public let mockProducts = [Product(_id: "0", calorie: 24, contents: [], description: "123", image: "pizza", name: "nee", rating: 44, stockCount: 56, price: 45.22),Product(_id: "1", calorie: 24, contents: [], description: "123", image: "pizza", name: "nee", rating: 44, stockCount: 56, price: 45.22),Product(_id: "2", calorie: 24, contents: [], description: "123", image: "pizza", name: "nee", rating: 44, stockCount: 56, price: 45.22),Product(_id: "0", calorie: 24, contents: [], description: "123", image: "pizza", name: "nee", rating: 44, stockCount: 56, price: 45.22),Product(_id: "1", calorie: 24, contents: [], description: "123", image: "pizza", name: "nee", rating: 44, stockCount: 56, price: 45.22),Product(_id: "2", calorie: 24, contents: [], description: "123", image: "pizza", name: "nee", rating: 44, stockCount: 56, price: 45.22)]
