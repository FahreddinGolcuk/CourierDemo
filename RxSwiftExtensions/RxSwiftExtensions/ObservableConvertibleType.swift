//
//  ObservableConvertibleType.swift
//  RxSwiftExtensions
//
//  Created by Fahreddin Gölcük on 7.12.2021.
//

import Foundation
import RxSwift
import RxCocoa

public extension ObservableConvertibleType {
    func apiCall<Target>(
            _ activityIndicator: ActivityIndicator? = nil,
            call: @escaping (Element) -> Target
        ) -> (Driver<Target.Element>, Driver<Error>) where Target: ObservableConvertibleType {
        
        let stream = self.asObservable()
            .flatMapLatest { element -> Observable<Event<Target.Element>> in
                if let activity = activityIndicator {
                    return call(element).asObservable()
                        .trackActivity(activity)
                        .materialize()
                } else {
                    return call(element).asObservable()
                        .materialize()
                }
            }
        .share(replay: 1)
        
        return (
            stream.compactMap { $0.element }.asDriver(onErrorDriveWith: .never()),
            stream.compactMap { $0.error }.asDriver(onErrorDriveWith: .never())
        )
    }
}

