//
//  PlantResponse.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 9/6/2564 BE.
//

import Foundation
import ObjectMapper

struct PlantResponse : Mappable {
    /**
                
     [{
             "plant1": "TH10",
             "desc_BU": "Bangkok",
             "desc_LO": "กรุงเทพมหานคร",
             "msrepl_tran_version": "5fc48db8-e0d7-411a-b181-2e10d3351a76"
         }]
     */
    var plant1: String?
    var desc_BU: String?
    var desc_LO: String?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        plant1 <- map["plant1"]
        desc_BU <- map["desc_BU"]
        desc_LO <- map["desc_LO"]
    }
    
    
}
