//
//  User.swift
//  Entities
//
//  Created by Fahreddin Gölcük on 13.12.2021.
//

import Foundation

public struct User: Codable {
    public let id, email, password, salt, name: String
    let v: Int
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email, password, salt, name
        case v = "__v"
        case refreshToken
    }
}

// MARK: -RegisterRequest
public struct RegisterRequest: Codable {
    let name: String
    let email: String
    let password: String
}

// MARK: -LoginRequest
public struct LoginRequest: Decodable,Equatable {
    public let email: String
    public let password: String
    
    public init(
        email: String,
        password: String
    ) {
        self.email = email
        self.password = password
    }
    
}

// MARK: - UserResponse
public struct UserResponse: Codable {
    public var message: String
    public var user: User
    var accessToken: String
    var status: Bool
}

// MARK: - UserResponse
public struct UserError: Codable {
    let message: String
    let status: Bool
}

