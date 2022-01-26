//
//  OrderConfirmationViewController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 25.01.2022.
//

import UIKit
import RxSwift

final class OrderConfirmationViewController: UIViewController {
    private(set) lazy var viewSource = OrderConfirmationView()
    private let viewModel: OrderConfirmationViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = viewSource
    }
    
    init(viewModel: @escaping OrderConfirmationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
