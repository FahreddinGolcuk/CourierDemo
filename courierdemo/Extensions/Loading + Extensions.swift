//
//  Loading + Extensions.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 7.12.2021.
//

import Foundation
import RxSwift
import RxCocoa
import CustomViews
// MARK: - UIViewController + Rx + Extensions
extension Reactive where Base: UIViewController {
    var showLoading: Binder<Bool> {
        Binder(base) { [weak base] _, isLoading in
            print(isLoading)
            base?.rx.showLoadingView.onNext(isLoading)
        }
    }
}
