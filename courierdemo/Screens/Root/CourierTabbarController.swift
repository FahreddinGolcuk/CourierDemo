//
//  CourierTabbarController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.11.2021.
//

import UIKit
import RxSwift

enum TabBarItemType: Int {
    case Main = 0, Search = 1, Payment = 2, Campaign = 3, Profile = 4
}

class CourierTabbarController: UITabBarController {

    var bag = DisposeBag()
    var viewModel: CourierTabbarViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModelOutputs()
        configureTabBarItems()
    }
    
    init(
        viewModel: @escaping CourierTabbarViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension CourierTabbarController {
    
    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        configureTabBar()
    }
    
    private func configureTabBarItems() {
        let controllers = configureTabbarControllers()
        setViewControllers(controllers, animated: false)
    }
    
    fileprivate func configureTabBar() {
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
    }
    
    func configureTabbarControllers() -> [UIViewController] {
        let loginNVC = createTabbarItem(for: HomeViewController(viewModel: homeViewModel), tabBarItemTitle: "Home", image: UIImage(systemName: "house")!, selectedImage: UIImage(systemName: "house.fill")!, tag: .Main)
        
        let searchNVC = createTabbarItem(for: SearchViewController(), tabBarItemTitle: "Search", image: UIImage(systemName: "magnifyingglass")!, selectedImage: UIImage(systemName: "magnifyingglass.circle.fill")!, tag: .Search)
        
        let paymentNVC = createTabbarItem(for: PaymentViewController(), tabBarItemTitle: "Payment", image: UIImage(systemName: "bag")!, selectedImage: UIImage(systemName: "bag.fill")!, tag: .Payment)
        
        let campaignNVC = createTabbarItem(for: CampaignViewController(), tabBarItemTitle: "Campaign", image: UIImage(systemName: "flame")!, selectedImage: UIImage(systemName: "flame.fill")!, tag: .Campaign)
        
        let profileNVC = createTabbarItem(for: ProfileViewController(), tabBarItemTitle: "Profile", image: UIImage(systemName: "person")!, selectedImage: UIImage(systemName: "person.fill")!, tag: .Profile)
        return [loginNVC, searchNVC, paymentNVC, campaignNVC, profileNVC]
    }
    
    private func createTabbarItem(for controller: UIViewController,
        tabBarItemTitle: String,
        image: UIImage,
        selectedImage: UIImage,
        tag: TabBarItemType) -> UIViewController {
        let navController = controller.makeNavigationController(with: controller)
        navController.tabBarItem = UITabBarItem(title: tabBarItemTitle, image: image.withRenderingMode(.alwaysOriginal), tag: tag.rawValue)
        navController.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        return navController
    }
}

// MARK: - Bind ViewModel Outputs
private extension CourierTabbarController {
    func bindViewModelOutputs() {
        let outputs = viewModel(inputs)
        
        bag.insert(
            outputs.cartBadgeCount.drive(rx.updateCartBadgeCount)
        )
    }
    
    var inputs: CourierTabbarViewModelInput {
        CourierTabbarViewModelInput(
            viewDidLoad: Observable.just(()),
            cartBadgeCount: Current.cartData.cartBadgeCount
        )
    }
}

// MARK: - Rx + Display
private extension Reactive where Base == CourierTabbarController {
    var updateCartBadgeCount: Binder<String?> {
        Binder(base) { target, count in
            let selected = TabBarItemType.Payment.rawValue
            let tabbarItems = target.tabBar.items ?? []
            let cartTabItem = tabbarItems.first {
                $0.tag == selected
            }
            cartTabItem?.badgeValue = count
        }
    }
}
