//
//  Order.swift
//  Entities
//
//  Created by Fahreddin Gölcük on 26.01.2022.
//


// MARK: -TotalPriceRequest
public struct TotalPriceRequest: Codable {
    public let productId: String
    public let quantity: Int
    
    public init(
        productId: String,
        quantity: Int
    ) {
        self.productId = productId
        self.quantity = quantity
    }
    
    public static func encode(input: [TotalPriceRequest]?) -> [[String : Any]]? {
        guard let input = input else { return nil }
        var params  = [[String : Any]]()
        for option in input {
            var param: [String: Any] = [:]
            param["productId"] = option.productId
            param["quantity"] = option.quantity
            params.append(param)
        }
        return params
    }
}

// MARK: -TotalPriceResponse
public struct TotalPriceResponse: Codable {
    public let status: Bool
    public let price: Double
}
