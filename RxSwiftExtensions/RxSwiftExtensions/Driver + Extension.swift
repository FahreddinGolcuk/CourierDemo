//
//  Driver + Extension.swift
//  RxSwiftExtensions
//
//  Created by Fahreddin Gölcük on 7.01.2022.
//

import Foundation
import RxSwift
import RxCocoa

public extension Driver {
    static func pipe() -> (observer: AnyObserver<Element>, driver: Driver<Element>) {
        let subject = PublishSubject<Element>()
        return (subject.asObserver(), subject.asDriver(onErrorDriveWith: .never()))
    }

    static func sharedPipe() -> (observer: AnyObserver<Element>, driver: Driver<Element>) {
        let subject = BehaviorSubject(value: nil as Element?)

        let observer = AnyObserver.init { (event: Event<Element>) in
            switch event {
            case .completed:
                subject.onCompleted()
            case .error(let error):
                subject.onError(error)
            case .next(let element):
                subject.onNext(element)
            }
        }

        let driver = subject.asObservable().compactMap { $0 }
            .asDriver(onErrorDriveWith: .never())

        return (observer, driver)
    }
}
