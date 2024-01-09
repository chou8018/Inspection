//
//  AppConfig.swift
//  dealers
//
//  Created by Hong Wei Zhuo on 19/12/17.
//  Copyright © 2017 Trusty Cars. All rights reserved.
//

import Foundation
import UIKit

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
    
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
}
