//
//  ProvinceModel.swift
//  Inspection
//
//  Created by Thanawat prathumset on 15/3/2564 BE.
//

import Foundation
import ObjectMapper

struct ProvinceModel : Mappable {
    
    /*
            "state1": "ANGT",
             "desc_BU": "Ang Thong",
             "desc_LO": "อ่างทอง"
     **/
    var state1 : String?
    var desc_BU : String?
    var desc_LO : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        state1 <- map["state1"]
        desc_BU <- map["desc_BU"]
        desc_LO <- map["desc_LO"]
    }
    
    
}
