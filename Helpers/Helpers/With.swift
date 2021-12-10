//
//  With.swift
//  Helpers
//
//  Created by Fahreddin Gölcük on 2.12.2021.
//

import Foundation

@discardableResult
@inlinable
public func with<T>(_ subject: T, _ transform: (_ subject: inout T) throws -> Void) rethrows -> T {
    var subject = subject
    try transform(&subject)
    return subject
}
