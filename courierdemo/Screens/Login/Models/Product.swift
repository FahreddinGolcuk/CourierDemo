//
//  Product.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 26.11.2021.
//

import Foundation

public struct Product: Codable {
    var _id: String
    var calorie: Int
    var contents: [String]
    var description: String
    var image: String
    var name: String
    var rating: Double
    var stockCount: Int
    var price: Double
}

let emptyProduct = Product(_id: "", calorie: 0, contents: [], description: "", image: "", name: "", rating: 0, stockCount: 0, price: 0)
