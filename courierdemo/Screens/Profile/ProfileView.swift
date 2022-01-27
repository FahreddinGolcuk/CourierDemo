//
//  ProfileView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.12.2021.
//

import UIKit
import Helpers

class ProfileView: UIView {
    // MARK: - Properties
    let tableView = with(UITableView()) {
        $0.estimatedRowHeight = 45.0
        $0.register(
            ProfileItemCell.self,
            forCellReuseIdentifier: ProfileItemCell.viewIdentifier
        )
        $0.register(
            LiveHelpCell.self,
            forCellReuseIdentifier: LiveHelpCell.viewIdentifier
        )
        $0.register(
            LogoutCell.self,
            forCellReuseIdentifier: LogoutCell.viewIdentifier
        )
    }
    
    init() {
        super.init(frame: .zero)
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfileView {
    func arrangeViews() {
        addSubview(tableView)
        tableView.alignFitEdges().activate()
    }
}
