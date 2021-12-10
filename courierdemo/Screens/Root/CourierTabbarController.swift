//
//  CourierTabbarController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.11.2021.
//

import UIKit

enum TabBarItemType: Int {
    case Main = 0, Search = 1, Basket = 2, LiveSupport = 3, Other = 4
}

class CourierTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarItems()
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
        let loginNVC = createTabbarItem(for: HomeViewController(viewModel: homeViewModel), tabBarItemTitle: "Home", image: UIImage(systemName: "star")!, selectedImage: UIImage(systemName: "star")!, tag: .Main)
        
        let searchNVC2 = createTabbarItem(for: SearchViewController(), tabBarItemTitle: "Search", image: UIImage(systemName: "star")!, selectedImage: UIImage(systemName: "star")!, tag: .Search)
        return [loginNVC, searchNVC2]
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
