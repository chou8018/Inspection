//
//  StorageLocation.swift
//  Inspection
//
//  Created by Thanawat prathumset on 16/3/2564 BE.
//

import Foundation
import ObjectMapper

struct StorageLocationModel : Mappable , Comparable {
    
    static func < (lhs: StorageLocationModel, rhs: StorageLocationModel) -> Bool {
        return lhs.distance < rhs.distance
    }
    
    /*
            "locationId": 1,
            "location": "Ang Thong"
     **/
    var locationId : Int?
    var location : String?
    var lat: NSNumber?
    var lon: NSNumber?
    var distance: Double = 0
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        locationId <- map["locationId"]
        location <- map["location"]
        lat <- map["lat"]
        lon <- map["lon"]
    }
}
