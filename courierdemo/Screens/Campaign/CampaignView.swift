//
//  CampaignView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.12.2021.
//

import UIKit
import Helpers

class CampaignView: UIView {
    private let campaignText = with(UILabel()){
        $0.text = "This section is coming very soon."
        $0.font = UIFont.Fonts.thinLarge
        $0.textColor = UIColor.Theme.title
        $0.textAlignment = .center
    }
    
    init() {
        super.init(frame: .zero)
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CampaignView {
    func arrangeViews() {
        [
            campaignText
        ].forEach(addSubview)
        
        [
            campaignText.alignFitEdges()
        ]
        .flatMap { $0 }
        .activate()
    }
}
