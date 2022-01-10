//
//  CategoryListView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 5.01.2022.
//

import UIKit
import Helpers

class CategoryListView: UIView {
    private lazy var flowLayout = with(UICollectionViewFlowLayout()) {
        $0.scrollDirection = .horizontal
        $0.itemSize = CGSize(width: screenWidth * 0.2, height: screenHeight * 0.05)
        $0.minimumLineSpacing = 16
        $0.invalidateLayout()
    }
    
    private(set) lazy var collectionView = with(UICollectionView(frame: .zero, collectionViewLayout: flowLayout)) {
        $0.showsHorizontalScrollIndicator = false
        $0.register(
            CategoryListCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryListCollectionViewCell.viewIdentifier
        )
    }
    
    init() {
        super.init(frame: .zero)
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryListView {
    func arrangeViews() {
        addSubview(collectionView)
        
        [
            collectionView.alignFitEdges(),
            [
                collectionView.alignHeight(screenHeight * 0.06)
            ]
        ]
        .flatMap { $0 }
        .activate()
    }
}
