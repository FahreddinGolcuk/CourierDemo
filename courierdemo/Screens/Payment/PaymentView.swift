//
//  PaymentView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.12.2021.
//

import Foundation
import UIKit
import Helpers
import Extensions

final class PaymentView: UIView {
    
    let trashBarButtonItem = with(UIBarButtonItem()) {
        $0.image = UIImage(named: "trash")
        $0.style = .plain
        $0.accessibilityLabel = "Sepeti boşalt"
    }
    
    private(set) lazy var emptyView = with(BasketEmptyView()) {
        $0.isHidden = true
    }
    
    private(set) lazy var tableView = with(UITableView()) {
        $0.backgroundColor = UIColor.Theme.bg2
        $0.estimatedRowHeight = 60.0
        $0.register(PaymentItemTableViewCell.self, forCellReuseIdentifier: PaymentItemTableViewCell.viewIdentifier)
    }
    
    private(set) lazy var stackView = vStack(
        space: 8
    )(
        tableView,
        emptyView
    )
    
    init() {
        super.init(frame: .zero)
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PaymentView {
    func arrangeViews() {
        addSubview(stackView)
        
        [
            stackView.alignFitEdges()
        ]
        .flatMap { $0 }
        .activate()
    }
}
