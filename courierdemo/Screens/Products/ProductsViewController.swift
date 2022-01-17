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
import Extensions

final class ProductsViewController: UIViewController, ProductsNavigator {
    let bag = DisposeBag()
    private let viewModel: ProductsViewModel
    fileprivate var productType: ProductTypes = .normal
    fileprivate var productList: [Product] = []
    private let selectedCategory: Observable<CategoryListDatasource>
    private let (viewDidDisappearObserver, viewDidDisappearEvent) = Observable<Void>.pipe()
    
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewDidDisappearObserver.onNext(())
    }

    init(viewModel: @escaping ProductsViewModel, type: ProductTypes, selectedCategory: Observable<CategoryListDatasource> = .never()) {
        self.viewModel = viewModel
        self.productType = type
        self.selectedCategory = selectedCategory
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewSource.collectionView.reloadData()
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
            outputs.setDatasource.drive(rx.setDatasourceProducts),
            outputs.showProductDetail.drive(rx.showProductDetail)
        )
    }
    
    var inputs: ProductsViewModelInput {
        let productSelected = viewSource.collectionView.rx.itemSelected
            .asObservable()
            .observe(on: MainScheduler.asyncInstance)
        
        return ProductsViewModelInput(
            viewDidLoad: .just(()),
            productSelected: productSelected,
            productType: productType,
            selectedCategory: selectedCategory
        )
    }
}

extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductItemCell = collectionView.dequeue(at: indexPath)
        let item = productList[indexPath.item]
        cell.populate.onNext(item)
        let quantity = Current.cartData.getBasketItemQuantity(with: item._id)
        cell.updateView.onNext(ProductItemEditViewDatasource(leftButtonImage: quantity == 1 ? "trash" : "decreaseAmount", quantity: quantity, showEditView: quantity > 0))
        let inputs = ProductItemViewModelInput(increaseButtonTapped: cell.increaseButtonTappedEvent, decreaseButtonTapped: cell.decreaseButtonTappedEvent, addProductButtonTapped: cell.plusButtonTappedEvent, product: item, selectedCategory: selectedCategory,viewDidDisapperEvent: viewDidDisappearEvent)
        let output = productItemViewModel(inputs)
        cell.bag.insert(
            output.increaseAmount.drive(cell.updateView),
            output.decreaseAmount.drive(cell.updateView),
            output.addTappedAmount.drive(cell.updateView),
            output.changedSelectedCategory.drive(cell.bagClear),
            output.updateView.drive(cell.updateView),
            output.viewDidDisappear.drive(cell.bagClear)
        )
        return cell
    }
}

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        ProductItemLayoutHelper.cellSize(layoutAxis: .vertical)
    }
}

private extension Reactive where Base == ProductsViewController {
    var showProductDetail: Binder<IndexPath> {
        Binder(base) { target, datasource in
            target.showProductDetail(data: target.productList[datasource.item])
        }
    }
}

extension Reactive where Base == ProductsViewController {
    var setDatasourceProducts: Binder<[Product]> {
        Binder(base) { target, datasource in
            target.productList = datasource
            target.viewSource.collectionView.reloadData()
        }
    }
}
