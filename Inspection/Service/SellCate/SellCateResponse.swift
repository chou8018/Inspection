//
//  SellCateResponse.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 22/6/2564 BE.
//

import Foundation
import ObjectMapper

struct SellCateResponse : Mappable {
    /**
    
        {
         "sellingCategory1": "CA ",
         "desc_BU": "Car",
         "desc_LO": "รถเก๋ง",
         "bodyRef": "S"
        }
     */
    
    var sellingCategory1:String?
    var desc_BU:String?
    var desc_LO:String?
    var bodyRef:String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        sellingCategory1 <- map["sellingCategory1"]
        desc_BU <- map["desc_BU"]
        desc_LO <- map["desc_LO"]
        bodyRef <- map["bodyRef"]
    }
    
    
}
