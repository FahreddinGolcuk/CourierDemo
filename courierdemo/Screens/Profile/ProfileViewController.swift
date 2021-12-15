//
//  ProfileViewController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 15.12.2021.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController {
    private let viewSource = ProfileView()
    private let bag = DisposeBag()
    
    override func loadView() {
        view = viewSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        title = "Profile"
        // Do any additional setup after loading the view.
    }

}
