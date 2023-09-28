//
//  AppConfig.swift
//  dealers
//
//  Created by Hong Wei Zhuo on 19/12/17.
//  Copyright © 2017 Trusty Cars. All rights reserved.
//

import Foundation

enum Environment:String {
    case production = "production"
    case staging = "staging"
}

struct AppConfig {
    
    static var baseProdUrl = "https://api.mottoauction.com/"
    static var baseStagingUrl = "http://mapapi-uat.mottoauction.com/"
    
    static var environment: Environment {
        if let environmentString = Bundle.main.infoDictionary?["Environment"] as? String {
            if environmentString.lowercased() == "production" {
                return .production
            }
        }
        return .staging
    }
    
    static var currentBaseUrl: String {
        if environment == .production {
            return baseProdUrl
        }
        return baseStagingUrl
    }
}
