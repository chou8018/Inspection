//
//  StorageLocation.swift
//  Inspection
//
//  Created by Thanawat prathumset on 16/3/2564 BE.
//

import Foundation
import ObjectMapper

struct StorageLocationModel : Mappable {
    /*
            "locationId": 1,
            "location": "Ang Thong"
     **/
    var locationId : Int?
    var location : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        locationId <- map["locationId"]
        location <- map["location"]
        
    }
    
}
