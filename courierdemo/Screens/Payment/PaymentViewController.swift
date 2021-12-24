//
//  PaymentViewController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.12.2021.
//

import UIKit
import RxSwift
import Helpers

final class PaymentViewController: UIViewController {
    
    fileprivate var cartInfo: [BasketItemInfo] = []
    
    let (reloadObserver, reloadEvent) = Observable<Void>.pipe()
    
    private(set) lazy var viewSource = with(PaymentView()) {
        $0.tableView.dataSource = self
        $0.tableView.delegate = self
    }
    
    private let bag = DisposeBag()
    
    private let viewModel: PaymentViewModel
    
    init(
        viewModel: @escaping PaymentViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = viewSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        title = "Payment"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(cartInfo)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

extension PaymentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Int(cartInfo.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PaymentItemTableViewCell = tableView.dequeue(at: indexPath)
        cell.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        let inputs = PaymentItemViewModelInput(viewDidLoad: .just(()), productId: cartInfo[indexPath.row].productId)
        let output = paymentItemViewModel(inputs)
        cell.bag.insert(
            output.populate.drive(cell.populate)
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if ( editingStyle == .delete ) {
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        12
    }
}

extension PaymentViewController {
    func bindViewModel() {
        let output = viewModel(input)
        
        bag.insert(
            output.cartProductData.drive(rx.setCartInfo)
        )
    }
    
    var input: PaymentViewModelInput {
        return PaymentViewModelInput(
            viewDidLoad: .just(()),
            reloadEvent: reloadEvent.startWith(())
        )
    }
}

extension PaymentViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath
    ) -> String? {
        Constants.delete
    }
}

extension Reactive where Base == PaymentViewController {
    var setCartInfo: Binder<[BasketItemInfo]> {
        Binder(base) { target, datasource in
            target.cartInfo = datasource
            target.viewSource.tableView.reloadData()
        }
    }
}

private enum Constants {
   static let delete = "Delete"
}
