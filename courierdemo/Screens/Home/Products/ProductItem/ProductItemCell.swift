//
//  ProductItemCell.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 10.12.2021.
//

import UIKit
import RxSwift
import Helpers
import Extensions

final class ProductItemCell: UICollectionViewCell {
    private(set) var bag = DisposeBag()
    
    private lazy var containerView = with(UIView()) {
        $0.layer.cornerRadius = 15.0
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor.Theme.secondary
    }
    
    private var image = with(UIImageView()) {
        $0.contentMode = .scaleAspectFit
    }
    
    private let title = with(UILabel()) {
        $0.font = UIFont.Fonts.boldSmall
        $0.textColor = UIColor.Theme.primary
        $0.textAlignment = .center
    }
    
    private let category = with(UILabel()) {
        $0.font = UIFont.Fonts.thinSmall
        $0.textColor = UIColor.Theme.third
        $0.textAlignment = .center
    }
    
    private let calorie = with(UILabel()) {
        $0.font = UIFont.Fonts.thinSmall
        $0.textColor = UIColor.Theme.title
        $0.textAlignment = .center
    }

    private let price = with(UILabel()) {
        $0.font = UIFont.Fonts.boldSmall
        $0.textColor = UIColor.Theme.primary
        $0.textAlignment = .center
    }

    
    lazy var stackView = vStack(
    space: 8
    )(
        image,
        title,
        category,
        calorie,
        price
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        [
           stackView
        ]
        .forEach(containerView.addSubview(_:))
        
        [
            stackView.alignFitEdges(),
            containerView.alignFitEdges(),
            [
                image.alignHeight(self.bounds.height * 0.4)
            ]
        ]
        .flatMap { $0 }
        .activate()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Populate UI
extension ProductItemCell {
    var populate: Binder<Product> {
        Binder(self) { target, datasource in
            target.title.text = datasource.name
            target.calorie.text = "\(datasource.calorie) cal"
            target.category.text = "Burger"
            target.price.text = "$ \(datasource.price)"
            target.image.image = UIImage(named: datasource.image)
        }
    }
}
