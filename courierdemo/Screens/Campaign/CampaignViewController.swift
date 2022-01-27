//
//  CampaignViewController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.12.2021.
//

import UIKit

class CampaignViewController: UIViewController {
    private let viewSource = CampaignView()
    
    override func loadView() {
        view = viewSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Campaign"
        // Do any additional setup after loading the view.
    }

}
