//
//  Request.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 26.11.2021.
//

import Foundation

public func Request<T: Decodable>(with url: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
    guard let url = URL(string: url) else {
        completion(.failure(.urlError))
        return
    }
    URLSession.shared.dataTask(with: url) { data, _, error in
        if let error = error {
            completion(.failure(NetworkError.networkError(error)))
        }
        guard let data = data else {
            completion(.failure(.dataNotFound))
            return
        }

        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(.networkError(error)))
        }
        
    }.resume()
}
