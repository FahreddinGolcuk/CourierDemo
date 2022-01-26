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
    
    let editingAmountView = ProductItemAmountView()
    
    var (increaseTapObserver, increaseTapEvent) = Observable<Void>.pipe()
    var (decreaseTapObserver, decreaseTapEvent) = Observable<Void>.pipe()
    
    private let name = with(UILabel()) {
        $0.textColor = .gray
        $0.font = UIFont.Fonts.boldSmall
    }
    
    private let calorie = with(UILabel()) {
        $0.textColor = .black
        $0.font = UIFont.Fonts.thinVerySmall
    }
    
    private let price = with(UILabel()) {
        $0.textColor = UIColor.Theme.primary
        $0.font = UIFont.Fonts.thinSmall
    }
    
    private var image = with(UIImageView()) {
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var infoStack = vStack(
        space: 2
    )(
        name,
        calorie,
        price
    )
    
    lazy var stack = hStack(
        space: 8
    )(
        image,
        infoStack,
        editingAmountView
    )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.addSubview(stack)
        stack.alignment = .center
        [
            image.alignSize(width: 75, height: 60),
            editingAmountView.alignSize(width: 80, height: 40),
            stack.alignEdges(leading: 15, trailing: -15, top: 10, bottom: -10),
        ]
        .flatMap { $0 }
        .activate()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        bag = DisposeBag()
    }
}

// MARK: - Populate UI
extension PaymentItemTableViewCell {
    var populate: Binder<Product> {
        Binder(self) { target, datasource in
            let quantity = Current.cartData.getBasketItemQuantity(with: datasource._id)
            target.name.text = datasource.name
            target.calorie.text = "\(datasource.calorie) cal"
            target.price.text = "\(datasource.price) TL"
            target.image.image = UIImage(named: datasource.image)
            if(quantity == 1) {
                target.editingAmountView.leftButton.setImage(UIImage(named: "trash"), for: .normal)
            } else {
                target.editingAmountView.leftButton.setImage(UIImage(named: "decreaseAmount"), for: .normal)
            }
            target.editingAmountView.quantityLabel.text = "\(quantity)"
            
            target.editingAmountView.rightButton.rx.tap
                .subscribe(onNext: { [weak target] in
                    target?.increaseTapObserver.onNext(())
                })
                .disposed(by: target.bag)
            
            target.editingAmountView.leftButton.rx.tap
                .subscribe(onNext: { [weak target] in
                    target?.decreaseTapObserver.onNext(())
                })
                .disposed(by: target.bag)
        }
    }
    
    var updateAmountView: Binder<PaymentItemAmountViewDatasource> {
        Binder(self) { target, datasource in
            target.editingAmountView.quantityLabel.text = "\(datasource.quantity)"
            target.editingAmountView.leftButton.setImage(UIImage(named: datasource.leftButtonImage), for: .normal)
        }
    }
}
