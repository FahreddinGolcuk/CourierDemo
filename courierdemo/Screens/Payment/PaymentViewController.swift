//
//  PaymentViewController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.12.2021.
//

import UIKit
import RxSwift

final class PaymentViewController: UIViewController {
    private let viewSource = PaymentView()
    private let bag = DisposeBag()
    
    override func loadView() {
        view = viewSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Payment"
    }
}
