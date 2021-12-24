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
    }
    
    private var image = with(UIImageView()) {
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var stack = hStack(
        space: 8
    )(
        image,
        name
    )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear // very important
        // add corner radius on `contentView`
          contentView.backgroundColor = .white
          contentView.layer.cornerRadius = 8
        contentView.addSubview(stack)
        [
            stack.alignFitEdges(),
            [
                image.alighWidth(screenWidth * 0.3),
                name.alignHeight(screenHeight * 0.1)
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
            target.name.text = datasource.name
            target.image.image = UIImage(named: datasource.image)
        }
    }
}
