//
//  AppEnvironment.swift
//  AppEnvironment
//
//  Created by Fahreddin Gölcük on 8.12.2021.
//

import Foundation

public var environment: AppEnvironment!


public class AppEnvironment {
    
    public var userName: String
    public var email:  String
    
    public init() {
        email = ""
        userName = ""
    }
}
