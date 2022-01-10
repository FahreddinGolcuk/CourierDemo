//
//  SearchView.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 18.11.2021.
//

import UIKit
import Extensions
import Helpers

class SearchView: UIView {
    
    let scrollView = with(UIScrollView(frame: .zero)) {
        $0.alwaysBounceVertical = true
    }
    
    private(set) lazy var title = with(UILabel()) {
        $0.text = "Are You Hungry"
        $0.font = UIFont.Fonts.boldMedium
    }
    
    private(set) lazy var subtitle = with(UILabel()) {
        $0.text = "What you want eat now bro?"
        $0.font = UIFont.Fonts.thinSmall
    }
    
    private(set) lazy var searchBar = with(UISearchBar(frame: .zero)) {
        $0.enablesReturnKeyAutomatically = true
        $0.returnKeyType = .search
        $0.placeholder = "Search"
    }
    
    private(set) lazy var stackView = vStack(
    space: 8
    )(
    title,
    subtitle,
    searchBar
    )
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView {
    func arrangeViews() {
        stackView.applyMargins(8)
        
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        [
            scrollView.alignFitEdges(),
            stackView.alignFitEdges(),
            [
                stackView.alighWidth(screenWidth)
            ]
        ]
        .flatMap { $0 }
        .activate()
    }
}
