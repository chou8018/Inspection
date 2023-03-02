//
//  JatoCarModelsModel.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 25/6/2564 BE.
//

import Foundation
import ObjectMapper

struct JatoCarModelsModel : Mappable {
    
    /**
     
         [
            {
             "model_BU": "FREELIFE"
            "model_LO": ""
            }
         ]
     */
    var model_BU: String?
    var model_LO: String?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        model_BU <- map["model_BU"]
        model_LO <- map["model_LO"]
    }
    
    
}
