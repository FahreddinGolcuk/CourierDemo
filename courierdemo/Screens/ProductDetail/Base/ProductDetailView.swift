//
//  ProductDetailView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 17.12.2021.
//

import UIKit
import Helpers
import Extensions

class ProductDetailView: UIView {
    
    private let propertyView = ProductDetailPropertyView()
    
    let backgroundImage = with(UIImageView()) {
        $0.image = UIImage(named: "product-background")
        $0.contentMode = .scaleToFill
    }
    
    let productTitle = with(UILabel()) {
        $0.textAlignment = .center
        $0.font = UIFont.Fonts.boldLarge
        $0.textColor = UIColor.Theme.black
    }
    
    let productDescription = with(UILabel()) {
        $0.textAlignment = .center
        $0.font = UIFont.Fonts.thinSmall
        $0.textColor = .systemGray
        $0.numberOfLines = 4
    }
    
    private let productImage = with(UIImageView()){
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var stack = vStack(
        space: 4
    )(
        productTitle,
        productDescription,
        productImage,
        propertyView
    )
    
    init() {
        super.init(frame: .zero)
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProductDetailView {
    func arrangeViews() {
        self.insertSubview(backgroundImage, at: 0)
        
        addSubview(stack)
        [
            backgroundImage.alignFitEdges(),
            stack.alignEdges(leading: 0, trailing: 0, top:0, bottom: -screenHeight * 0.36),
            [
                propertyView.alignHeight(50),
                productImage.alignTop(to: productDescription, offset: 40)
            ]
        ]
        .flatMap { $0 }
        .activate()
    }
}

extension ProductDetailView {
    func populate(data: Product) {
        productImage.image = UIImage(named: data.image)
        productTitle.text = data.name
        productDescription.text = data.description
        propertyView.productCalorie.text = "\(data.calorie) cal"
        propertyView.productRating.text = "\(data.rating)"
    }
}
