//
//  UICollectionView + Extensions.swift
//  Extensions
//
//  Created by Fahreddin Gölcük on 11.12.2021.
//

import UIKit

public extension UICollectionView {
    func dequeue<T: ViewIdentifier>(at indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(
                withReuseIdentifier: T.viewIdentifier,
                for: indexPath
            ) as? T
        else {
            fatalError("can not deque cell identifier \(T.viewIdentifier) from collectionView \(self)")
        }
        return cell
    }
    
    func dequeueHeader<T: ViewIdentifier>(kind: String, at indexPath: IndexPath) -> T {
        guard
            let sectionHeader = dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: T.viewIdentifier,
                for: indexPath
            ) as? T
        else {
            fatalError("can not deque collection header with identifier \(T.viewIdentifier) from collectionView \(self)")
        }
        return sectionHeader
    }
}

