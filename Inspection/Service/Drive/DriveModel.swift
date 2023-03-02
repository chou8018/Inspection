//
//  DriveModel.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import ObjectMapper

struct DriveModel : Mappable {
   
    /**
            
            
    [
     {
        "drive1": "F",
        "desc_BU": "Front Wheel Drive",
        "desc_LO": "ขับเคลื่อนลัอหน้า"
     }
    ]
     */
    var drive1:String?
    var desc_BU:String?
    var desc_LO:String?
    
   
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.drive1 <- map["drive1"]
        self.desc_BU <- map["desc_BU"]
        self.desc_LO <- map["desc_LO"]
    }
}
