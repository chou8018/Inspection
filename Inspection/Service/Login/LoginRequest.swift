//
//  LoginRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 6/5/2564 BE.
//

import Foundation
import ObjectMapper

struct LoginRequest : Mappable {
    
    /**
     {
     "username" : "thanawatp",
     "password" : "abcd@1234"
     }
     */
    var username: String? = ""
    var password: String? = ""
    
    init?(map: Map) {
        
    }
    
    
    init(username: String?, password: String? ) {
        self.username = username ?? ""
        self.password = password ?? ""
    }
    
    mutating func mapping(map: Map) {
        username  <- map["username"]
        password  <- map["password"]
    }
    
    
}
