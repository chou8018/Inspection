//
//  JatoVaraintsModel.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 25/6/2564 BE.
//

import Foundation
import ObjectMapper

struct JatoVaraintsModel : Mappable {
    
    /**
     
         [
             {
                 "model_BU": "MAZDA2",
                 "variants": "1.3 100TH ANNIVERSARY EDITION AUTO"
             }
         ]
     */
    var model_BU: String?
    var variants: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.model_BU <- map["model_BU"]
        self.variants <- map["variants"]
        
    }
    
    
}
