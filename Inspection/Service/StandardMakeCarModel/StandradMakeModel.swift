//
//  StandradMakeModel.swift
//  Inspection
//
//  Created by Thanawat prathumset on 15/3/2564 BE.
//

import Foundation
import ObjectMapper

struct StandradMakeModel : Mappable {
    
 /*
            "make1": "02",
            "desc_BU": "Alfa Romeo",
            "desc_LO": "Alfa Romeo"
     
     */
    var make1: String?
    var desc_BU: String?
    var desc_LO: String?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        make1 <- map["make1"]
        desc_BU <- map["desc_BU"]
        desc_LO <- map["desc_LO"]
    }
}
