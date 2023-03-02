//
//  JatoVaraintsModelRequest.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 25/6/2564 BE.
//

import Foundation
import ObjectMapper

struct JatoVaraintsModelRequest : Mappable {
    
    var model_BU: String = ""
    
    init(model_BU: String = "") {
        self.model_BU = model_BU
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
    }
    
    
    
}
