//
//  HomeViewController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 18.11.2021.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController, HomeNavigator {
    private lazy var viewSource = HomeView()
    private let viewModel: HomeViewModel
    
    private(set) lazy var bag = DisposeBag()
    
    
    private lazy var bestProducts: ProductsViewController = {
        ProductsViewController(
            viewModel: productsViewModel
        )
    }()
    
    override func loadView() {
        view = viewSource
        view.backgroundColor = .white
    }
    
    init(
        viewModel: @escaping HomeViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        configureNavigationBar()
        bindViewModel()
        addChildren()
    }
}

extension HomeViewController {
    
    func addChildren() {
        let controllers = [
            bestProducts
        ]
        controllers.forEach {
            addChildController(controller: $0) {
                viewSource.stackView.addArrangedSubview($0)
            }
        }
    }
    
    private func configureNavigationBar() {
        navigationItem.titleView = viewSource.logoImageView
    }
    
    private func bindViewModel() {
        let output = viewModel(input)
        bag.insert(
            output.showLoginScreen.drive(rx.showLoginScreen),
            output.showEntryStack.drive(viewSource.rx.isShowEntryStack),
            output.titleName.drive(viewSource.rx.setNameLabel)
        )
    }
    
    private var input: HomeViewModelInput {
        let loginButtonTapped = viewSource.loginButton.rx.tap.asObservable()
        
        return HomeViewModelInput(
            viewDidLoad: .just(()),
            tappedLoginScreen: loginButtonTapped
        )
    }
}

extension Reactive where Base == HomeViewController {
    var showLoginScreen: Binder<Void> {
        Binder(base) { target, _ in
            target.showLoginScreen()
        }
    }
}

