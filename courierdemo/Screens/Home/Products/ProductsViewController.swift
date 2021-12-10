//
//  ProductsViewController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 10.12.2021.
//

import Foundation
import UIKit
import RxSwift
import Helpers

final class ProductsViewController: UIViewController {
    let bag = DisposeBag()
    private let viewModel: ProductsViewModel
    private(set) lazy var viewSource = with(ProductsView()) {
        $0.collectionView.delegate = self
        $0.collectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    UICollectionViewCell()
    }
    
    
}

extension ProductsViewController: UICollectionViewDelegate {
    
}
