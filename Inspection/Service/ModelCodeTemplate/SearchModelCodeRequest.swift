//
//  SearchModelCodeRequest.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import ObjectMapper

struct SearchModelRequest : Mappable {
    var strValue1:String = ""
    
    init(strValue1:String = "") {
        self.strValue1 = strValue1
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.strValue1 <- map["strValue1"]
    }
    
    
}
