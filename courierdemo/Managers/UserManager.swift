//
//  UserManager.swift
//  courierdemo
//
//  Created by Fahreddin Gölcük on 8.12.2021.
//

import Foundation

final class UserManager: NSObject {
    
    var fullName: String? {
        get {
           return "selamun aleykum"
        }
    }
    
    //MARK: Singleton
    private static let instance = UserManager()
    
    static var shared: UserManager {
        return instance
    }
}
