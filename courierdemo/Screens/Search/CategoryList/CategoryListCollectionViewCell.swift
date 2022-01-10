//
//  CategoryListCollectionViewCell.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 5.01.2022.
//

import UIKit
import struct Entities.Category
import RxCocoa
import RxSwift
import func Helpers.with
import Extensions

class CategoryListCollectionViewCell: UICollectionViewCell {
    
    lazy var bag = DisposeBag()
    
    private lazy var containerView = with(UIView()) {
        $0.layer.cornerRadius = 15.0
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor.Theme.secondary
    }
    
    private lazy var stack = hStack()(
        image,
        title
    )
    
    private let title = with(UILabel()) {
        $0.font = UIFont.Fonts.boldSmall
        $0.textColor = UIColor.Theme.primary
        $0.textAlignment = .center
    }
    
    private var image = with(UIImageView()) {
        $0.contentMode = .scaleAspectFit
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        [
            stack
        ].forEach(containerView.addSubview)
        
        [
            containerView.alignFitEdges(),
            stack.alignFitEdges(),
            [
                image.alighWidth(self.bounds.width * 0.2)
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
extension CategoryListCollectionViewCell {
    var populate: Binder<Category> {
        Binder(self) { target, datasource in
            target.title.text = datasource.name
            target.image.image = UIImage(named: datasource.image)
        }
    }
    
    var isSelectedCategory: Binder<Bool> {
        Binder(self) { target, isSelected in
            target.containerView.backgroundColor = isSelected ? UIColor.Theme.primary : UIColor.Theme.inactive
            target.title.textColor = isSelected ? .white : UIColor.Theme.primary
        }
    }
}
