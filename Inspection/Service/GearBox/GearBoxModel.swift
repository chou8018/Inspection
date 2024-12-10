//
//  GearBoxModel.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import ObjectMapper

struct GearBoxModel : Mappable {
    /**
     
         [
             {
                 "gearBox1": "1",
                 "desc_BU": "N/A",
                 "desc_LO": "N/A"
             }
         ]
     
     */
    var gearBox1: String?
    var desc_BU: String?
    var desc_LO: String?

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.gearBox1 <- map["gearBox1"]
        self.desc_BU <- map["desc_BU"]
        self.desc_LO <- map["desc_LO"]
    }
}
