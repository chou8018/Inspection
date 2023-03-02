//
//  FuelType.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import ObjectMapper

struct FuelTypeModel : Mappable {
    /**
     
         [
             {
                 "fuelType1": "P",
                 "desc_BU": "Petrol",
                 "desc_LO": "เบนซิน"
             }
         ]
     */
    
    var fuelType1: String?
    var desc_BU: String?
    var desc_LO: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.fuelType1 <- map["fuelType1"]
        self.desc_BU <- map["desc_BU"]
        self.desc_LO <- map["desc_LO"]
    }
    
    
}
