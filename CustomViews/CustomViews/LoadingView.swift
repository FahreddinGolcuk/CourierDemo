//
//  LoadingView.swift
//  CustomViews
//
//  Created by Fahreddin Gölcük on 7.12.2021.
//

import UIKit
import Helpers
import Extensions
import RxSwift
import RxCocoa

final class LoadingView: UIView {
    private enum Constant {
        static let loadingViewEdgeLength: CGFloat = 80.0
    }
    
    private let backgroundView = with(UIView()) {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    private lazy var loadingText = with(UILabel()){
        $0.text = "Loading..."
        $0.textAlignment = .center
    }
    
    init() {
        super.init(frame: .zero)
        arrangeSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)
        for view in self.subviews {
            if !view.isHidden && view.point(inside: self.convert(point, to: view), with: event) {
                return true
            }
        }
        return false
    }
}

extension LoadingView {
    func arrangeSubviews() {
        [
            backgroundView,
            loadingText
        ].forEach(addSubview(_:))
        
        [
            backgroundView.alignFitEdges(),
            [
                loadingText.centerX(in: self),
                loadingText.centerY(in: self),
                loadingText.alignHeight(Constant.loadingViewEdgeLength),
                loadingText.alighWidth(Constant.loadingViewEdgeLength)
            ]
        ]
        .flatMap { $0 }
        .activate()
        
    }
    
    func setEditableLoadingView(_ isEditable: Bool = false) {
        backgroundView.isHidden = isEditable
    }
}

// MARK: - UIViewController + Extensions
public extension UIViewController {
    /// This method shows loading gif by creating a new one.
    /// - Parameters:
    ///   - isEditable: Represents that UI interaction is enable or not. If you want to lock ui interactions, then set it as `false`. Otherwise, set it as `true`.
    ///   - container: Represents target view to remove currently active loading gif.
    func showLoadingView(isEditable: Bool, container: UIView? = nil) {
        let loadingView = LoadingView()
        loadingView.setEditableLoadingView(isEditable)
        let parentView = container == nil ? view : container
        parentView?.addSubview(loadingView)
        loadingView.alignFitEdges().activate()
    }
    
    /// This method removes the currently active loading gif.
    /// - Parameter container: Represents target view to remove currently active loading gif.
    func hideLoadingView(container: UIView? = nil) {
        let subViews = container == nil
            ? view.subviews
            : (container?.subviews ?? [])
        
        for loadingView in subViews where loadingView is LoadingView {
            loadingView.removeFromSuperview()
        }
    }
}

// MARK: - UIViewController + Rx + Extensions
public extension Reactive where Base: UIViewController {
    /// This Binder can show & hide loading gif.
    /// IMPORTANT: Don't use it inside of your viewController directly.
    var showLoadingView: Binder<Bool> {
        Binder(base, binding: { target, data in
            let isLoading = data
            if isLoading {
                target.navigationController?.navigationBar.isUserInteractionEnabled = false
                target.showLoadingView(isEditable: false)
            } else {
                target.hideLoadingView()
                target.navigationController?.navigationBar.isUserInteractionEnabled = true
            }
        })
    }
}
