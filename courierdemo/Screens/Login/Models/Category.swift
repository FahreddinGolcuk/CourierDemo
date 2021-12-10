//
//  Category.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 26.11.2021.
//

import Foundation

public struct Category: Codable {
     let _id: String
     let image: String
     let name: String
     let productCount: Int
     var products: [Product]
}
