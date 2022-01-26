//
//  PaymentViewController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.12.2021.
//

import UIKit
import RxSwift
import Helpers
import Entities

final class PaymentViewController: UIViewController {
    var bag = DisposeBag()
    fileprivate var cartInfo: [BasketItemInfo] = []
    
    let (reloadObserver, reloadEvent) = Observable<Void>.pipe()
    
    let orderConfirmation = OrderConfirmationViewController(viewModel: orderConfirmationViewModel(_:))
    
    private(set) lazy var viewSource = with(PaymentView()) {
        $0.tableView.dataSource = self
        $0.tableView.delegate = self
    }
    
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
        addChildren()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewSource.tableView.reloadData()
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
        let inputs = PaymentItemViewModelInput(viewDidLoad: .just(()), productId: cartInfo[indexPath.row].productId, increaseTap: cell.increaseTapEvent, decreaseTap: cell.decreaseTapEvent)
        let output = paymentItemViewModel(inputs)
        
        cell.bag.insert(
            output.populate.drive(cell.populate),
            output.increase.drive(cell.updateAmountView),
            output.decrease.drive(cell.updateAmountView),
            output.calculatePriceActions.drive(reloadObserver)
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        12
    }
}

extension PaymentViewController {
    func bindViewModel() {
        let output = viewModel(input)
        
        bag.insert(
            output.cartProductData.drive(rx.setCartInfo),
            output.cartDeleted.drive(rx.cartDeleted),
            output.cartRemoved.drive(rx.deneme),
            output.cartPriceAction.drive(rx.setTotalPrice)
        )
    }
    
    var input: PaymentViewModelInput {
        let indexDeleted = viewSource.tableView.rx.itemDeleted.asObservable()
        let trashTapped = viewSource.trashBarButtonItem.rx.tap.asObservable()
        return PaymentViewModelInput(
            viewDidLoad: .just(()),
            reloadEvent: reloadEvent.startWith(()),
            indexDeleted: indexDeleted,
            trashTapped: trashTapped
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
            if( datasource.isEmpty ) {
                target.viewSource.emptyView.isHidden = false
                target.viewSource.tableView.isHidden = true
                target.orderConfirmation.viewSource.isHidden = true
            } else {
                target.viewSource.emptyView.isHidden = true
                target.viewSource.tableView.isHidden = false
                target.orderConfirmation.viewSource.isHidden = false
            }
            
            if !datasource.isEmpty {
                target.navigationItem.leftBarButtonItem = target.viewSource.trashBarButtonItem
            } else {
                target.navigationItem.leftBarButtonItem = nil
            }
        }
    }
    
    var cartDeleted: Binder<TotalPriceResponse> {
        Binder(base) { target, datasource in
            target.cartInfo = Current.cartData.getBasketInfo
            if( Current.cartData.getBasketInfo.isEmpty ) {
                target.viewSource.emptyView.isHidden = false
                target.viewSource.tableView.isHidden = true
                target.orderConfirmation.viewSource.isHidden = true
            } else {
                target.viewSource.emptyView.isHidden = true
                target.viewSource.tableView.isHidden = false
                target.orderConfirmation.viewSource.isHidden = false
            }
            target.orderConfirmation.viewSource.totalPrice.text = "$ \(String(format: "%.2f", datasource.price))"
            target.viewSource.tableView.reloadData()
        }
    }
    
    var setTotalPrice: Binder<TotalPriceResponse> {
        Binder(base) { target, datasource in
            target.orderConfirmation.viewSource.totalPrice.text = "$ \(String(format: "%.2f", datasource.price))"
        }
    }
    
    var deneme: Binder<TotalPriceResponse> {
        Binder(base) { target, datasource in
            let alertController = UIAlertController(
                title: Constants.trashTitle,
                message: Constants.trashMessage,
                preferredStyle: .actionSheet
            )
            let logoutAction = UIAlertAction(
                title: Constants.trashTitle,
                style: .destructive,
                handler: { [weak target] _ -> Void in
                    guard target != nil else { return }
                    target!.cartInfo = Current.cartData.getBasketInfo
                    target!.orderConfirmation.viewSource.totalPrice.text = "$ \(String(format: "%.2f", 0))"
                    if( Current.cartData.getBasketInfo.isEmpty ) {
                        target!.viewSource.emptyView.isHidden = false
                        target!.viewSource.tableView.isHidden = true
                        target!.orderConfirmation.viewSource.isHidden = true
                        target!.navigationItem.leftBarButtonItem = nil
                    } else {
                        target!.viewSource.emptyView.isHidden = true
                        target!.viewSource.tableView.isHidden = false
                        target!.orderConfirmation.viewSource.isHidden = false
                        target!.navigationItem.leftBarButtonItem = target!.viewSource.trashBarButtonItem
                    }
                    target!.viewSource.tableView.reloadData()
                })
            let dismissAction = UIAlertAction(
                title: Constants.trashCancel,
                style: .cancel,
                handler: { Void -> Void in
                    alertController.dismiss(animated: true, completion: nil)
                })
            
            alertController.addAction(logoutAction)
            alertController.addAction(dismissAction)
            
            target.present(alertController, animated: true, completion: nil)
        }
    }
}

extension PaymentViewController {
    func addChildren() {
        let controllers = [
            orderConfirmation
        ]
        controllers.forEach {
            addChildController(controller: $0) {
                viewSource.stackView.addArrangedSubview($0)
            }
        }
    }
}

private enum Constants {
   static let delete = "Delete"
   static let trashTitle = "Remove"
   static let trashMessage = "Are you sure to remove your basket?"
   static let trashCancel = "Cancel"
}
