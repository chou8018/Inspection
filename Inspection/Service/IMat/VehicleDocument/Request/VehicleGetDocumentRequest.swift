//
//  VehicleGetDocumentRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 27/5/2564 BE.
//

import Foundation
import ObjectMapper

struct VehicleGetDocumentRequest : Mappable {
    var vehicleId:String = ""
    var documentTypeID:Int?
    init?(map: Map) {
        
    }
    
    init(vehicleId:String, documentTypeID:Int?) {
        self.vehicleId = vehicleId
        self.documentTypeID = documentTypeID
    }
    
    mutating func mapping(map: Map) {
        self.vehicleId <- map["vehicleId"]
        self.documentTypeID <- map["documentTypeID"]
    }
    
    
}
