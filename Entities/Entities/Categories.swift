//
//  Category.swift
//  Entities
//
//  Created by Fahreddin Gölcük on 17.12.2021.
//

import Foundation

public struct CategoryItem: Codable {
    public let _id: String
    public let image: String
    public let name: String
    public let productCount: Int
    public let products: [Product]
}
