//
//  BodyCarModel.swift
//  Inspection
//
//  Created by Thanawat prathumset on 15/3/2564 BE.
//

import Foundation
import ObjectMapper


struct BodyCarModel : Mappable {
    /*
            "body1": "DPCT",
            "desc_BU": "Double concrete powder container truck",
            "desc_LO": "รถบรรทุกซีเมนต์ผง"
     **/
    var body1 : String?
    var desc_BU : String?
    var desc_LO : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        body1 <- map["body1"]
        desc_BU <- map["desc_BU"]
        desc_LO <- map["desc_LO"]
    }
    
        
}
