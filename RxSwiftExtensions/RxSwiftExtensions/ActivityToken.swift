//
//  ActivityToken.swift
//  RxSwiftExtensions
//
//  Created by Fahreddin Gölcük on 7.12.2021.
//

import Foundation
import RxSwift
import RxCocoa

struct ActivityTokeneee<E> : ObservableConvertibleType, Disposable {
    private let _source: Observable<E>
    private let _dispose: Cancelable

    init(source: Observable<E>, disposeAction: @escaping () -> Void) {
        _source = source
        _dispose = Disposables.create(with: disposeAction)
    }

    func dispose() {
        _dispose.dispose()
    }

    func asObservable() -> Observable<E> {
        return _source
    }
}
