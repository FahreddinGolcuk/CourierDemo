//
//  Product.swift
//  Entities
//
//  Created by Fahreddin Gölcük on 10.12.2021.
//

import Foundation

public struct Product: Codable {
    public let _id: String
    public let calorie: Int
    public let contents: [String]
    public let description: String
    public let image: String
    public let name: String
    public let rating: Double
    public let stockCount: Int
    public let price: Double
}

