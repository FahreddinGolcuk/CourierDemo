//
//  UITableView + Extensions.swift
//  Extensions
//
//  Created by Fahreddin Gölcük on 23.12.2021.
//

import Foundation
import UIKit

// MARK: - Dequeue
public extension UITableView {
    func dequeue<T: ViewIdentifier>(at indexPath: IndexPath) -> T {
        guard
            let cell = self.dequeueReusableCell(
                withIdentifier: T.viewIdentifier,
                for: indexPath
            ) as? T
        else {
            fatalError("can not deque cell with identifier \(T.viewIdentifier) from tableView \(self)")
        }
        return cell
    }
}
