//
//  ProductsView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 10.12.2021.
//

import Foundation
import UIKit
import Helpers

final class ProductsView: UIView {
    
    private(set) lazy var collectionView = with(UICollectionView()) {
        $0.alwaysBounceVertical = true
        $0.register(ProductItemCell.self, forCellWithReuseIdentifier: ProductItemCell.viewIdentifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
