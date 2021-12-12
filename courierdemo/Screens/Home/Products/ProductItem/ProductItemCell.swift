//
//  ProductItemCell.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 10.12.2021.
//

import UIKit
import RxSwift
import Helpers

final class ProductItemCell: UICollectionViewCell {
    private(set) var bag = DisposeBag()
    
    private lazy var containerView = with(UIView()) {
        $0.layer.cornerRadius = 15.0
        $0.layer.masksToBounds = true
        $0.backgroundColor = .blue
    }
    
    private let titleLabel = with(UILabel()) {
        $0.text = "Denee"
        $0.font = .systemFont(ofSize: 11.0, weight: .semibold)
        $0.textColor = .gray
        $0.textAlignment = .center
        $0.setContentHuggingPriority(.required, for: .vertical)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        [
            titleLabel
        ]
        .forEach(containerView.addSubview(_:))
        
        [
            containerView.alignFitEdges(),
            [
                titleLabel.alignTop(to: containerView),
                titleLabel.alignLeading(to: containerView),
                titleLabel.alignTrailing(to: containerView),
                titleLabel.alignBottom(to: containerView)
            ]
        ]
        .flatMap { $0 }
        .activate()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
