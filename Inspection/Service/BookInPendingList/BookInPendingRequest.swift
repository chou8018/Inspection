//
//  BookInPendingRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 6/5/2564 BE.
//

import Foundation
import ObjectMapper

struct BookInPendingRequest : Mappable {
    
    var email:String = ""
    
    init?(map: Map) {
        
    }
    init(email : String?) {
        self.email = email ?? ""
    }
    
    mutating func mapping(map: Map) {
        email <- map["email"]
    }
    
    
}
