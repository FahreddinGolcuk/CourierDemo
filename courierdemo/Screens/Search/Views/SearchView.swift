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
    let stackView = vStack(space: 8)()
    
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
