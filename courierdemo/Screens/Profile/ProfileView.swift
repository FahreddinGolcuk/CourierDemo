//
//  ProfileView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.12.2021.
//

import UIKit
import Helpers

class ProfileView: UIView {
    private let profileTitle = with(UILabel()) {
        $0.text = "Profile"
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
        [
           profileTitle
        ].forEach(addSubview)
        
        [
            profileTitle.alignFitEdges()
        ]
        .flatMap { $0 }
        .activate()
    }
}
