//
//  FuelDeliveryModel.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import ObjectMapper

struct FuelDeliveryModel : Mappable {
    /**
     
         [
             {
                 "fuelDelivery1": "D",
                 "desc_BU": "Direct Injection",
                 "desc_LO": null
             }
         ]
     */
    
    var fuelDelivery1: String?
    var desc_BU: String?
    var desc_LO: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.fuelDelivery1 <- map["fuelDelivery1"]
        self.desc_BU <- map["desc_BU"]
        self.desc_LO <- map["desc_LO"]
    }
    
    
}
