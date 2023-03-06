//
//  MakeVehicleResponse.swift
//  Inspection
//
//  Created by Thanawat prathumset on 20/5/2564 BE.
//

import Foundation
import ObjectMapper

struct MakeRepoResponse : Mappable {

    var vehicleNo: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.vehicleNo <- map["vehicleNo"]
    }
}
