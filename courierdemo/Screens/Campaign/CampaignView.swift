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
        $0.text = "Campaign"
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
