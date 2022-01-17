//
//  PaymentItemTableViewCell.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 23.12.2021.
//

import UIKit
import Helpers
import RxSwift
import Extensions

class PaymentItemTableViewCell: UITableViewCell {

    private(set) var bag = DisposeBag()
    
    private let name = with(UILabel()) {
        $0.textColor = .gray
        $0.font = UIFont.Fonts.boldSmall
    }
    
    private let calorie = with(UILabel()) {
        $0.textColor = .black
    }
    
    private let price = with(UILabel()) {
        $0.textColor = UIColor.Theme.primary
        $0.font = UIFont.Fonts.boldMedium
    }
    
    private var image = with(UIImageView()) {
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var infoStack = vStack(
        space: 12
    )(
        name,
        calorie,
        price
    )
    
    lazy var stack = hStack(
        space: 8
    )(
        image,
        infoStack
    )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.addSubview(stack)
        [
            stack.alignFitEdges(),
            [
                image.alighWidth(screenWidth * 0.3),
                infoStack.alignHeight(screenHeight * 0.15)
            ]
        ]
        .flatMap { $0 }
        .activate()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
             contentView.frame = contentView.frame.inset(by: margins)
             contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Populate UI
extension PaymentItemTableViewCell {
    var populate: Binder<Product> {
        Binder(self) { target, datasource in
            let quantity = Current.cartData.getBasketItemQuantity(with: datasource._id)
            target.name.text = datasource.name
            target.calorie.text = "\(datasource.calorie) cal"
            target.price.text = "\(datasource.price * Double(quantity)) TL"
            target.image.image = UIImage(named: datasource.image)
        }
    }
}
