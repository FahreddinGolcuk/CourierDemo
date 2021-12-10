//
//  SearchViewController.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 18.11.2021.
//

import UIKit

class SearchViewController: UIViewController {
    private lazy var viewSource = SearchView()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view = viewSource
        // Do any additional setup after loading the view.
    }
}
