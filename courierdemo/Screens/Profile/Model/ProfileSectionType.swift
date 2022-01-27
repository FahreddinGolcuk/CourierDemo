//
//  ProfileSectionType.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 27.01.2022.
//

import UIKit
import Foundation

enum ProfileSectionItem: CaseIterable {
    case profile, previousOrders, favorites, adresses, aboutApp, liveHelp, logout
    var title: String {
        switch self {
        case .profile:
            return Constants.profile
        case .previousOrders:
            return Constants.previousOrders
        case .adresses:
            return Constants.adresses
        case .favorites:
            return Constants.favorites
        case .liveHelp:
            return Constants.liveHelp
        case .aboutApp:
            return Constants.aboutApp
        case .logout:
            return Constants.logOut
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .profile:
            return UIImage(systemName: "person.crop.circle.fill")
        case .previousOrders:
            return UIImage(systemName: "cart.fill")
        case .adresses:
            return UIImage(systemName: "location.circle.fill")
        case .favorites:
            return UIImage(systemName: "star.fill")
        case .liveHelp:
            return UIImage(systemName: "person.crop.circle.fill")
        case .aboutApp:
            return UIImage(systemName: "info.circle.fill")
        case .logout:
            return UIImage(systemName: "power.circle.fill")
        }
    }
}

enum ProfileSectionType: CaseIterable {
    case infoSection, liveHelp, logoutSection
    var rows: [ProfileSectionItem] {
        switch self {
        case .infoSection:
            return [.profile, .previousOrders, .favorites, .adresses, .aboutApp]
        case .liveHelp:
            return [.liveHelp]
        case .logoutSection:
            return [.logout]
        }
    }
    
    var sectionHeaderHeight: CGFloat {
        switch self {
        case .infoSection:
            return 0
        case .liveHelp:
            return 20.0
        case .logoutSection:
            return 40.0
        }
    }
}

// MARK: - Constants
private enum Constants {
    static let profile = "My Informations"
    static let previousOrders = "Previous Orders"
    static let favorites = "My Favourites"
    static let adresses = "Adresses"
    static let creditCards = "Credit Cards"
    static let aboutApp = "About Application"
    static let logOut = "Çıkış"
    static let liveHelp = "Canlı Yardım"
}
