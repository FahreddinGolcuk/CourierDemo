//
//  NetworkError.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 26.11.2021.
//

public enum NetworkError: Error {
    case networkError(Error)
    case dataNotFound
    case urlError
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
}

