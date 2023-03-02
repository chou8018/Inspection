//
//  BodyTypeModel.swift
//  Inspection
//
//  Created by Thanawat prathumset on 16/3/2564 BE.
//

import Foundation
import ObjectMapper

struct BodyTypeModel : Mappable {
    /*
            "languageID": 19,
            "bodyTypeCode": "3C",
            "bodyType": "tricycle"
     **/
    var languageID : Int?
    var bodyTypeCode : String?
    var bodyType : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        languageID <- map["languageID"]
        bodyTypeCode <- map["bodyTypeCode"]
        bodyType <- map["bodyType"]
    }
    
        
}
