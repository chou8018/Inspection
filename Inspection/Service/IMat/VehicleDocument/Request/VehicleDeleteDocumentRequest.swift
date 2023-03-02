//
//  VehicleDeleteDocumentRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 27/5/2564 BE.
//

import Foundation
import ObjectMapper

struct VehicleDeleteDocumentRequest : Mappable {
    
    /**
     
             {
             "documentId" : 1
             "vehicleId" : "000000000001379851",
             }
     */
    
    var documentId:Int?
    var vehicleId:String?
    
    
    init?(map: Map) {
        
    }
    
    init(documentId:Int?, vehicleId:String?) {
        self.documentId = documentId
        self.vehicleId = vehicleId
    }
    
    mutating func mapping(map: Map) {
        self.documentId <- map["documentId"]
        self.vehicleId <- map["vehicleId"]
    }
    
    
}
