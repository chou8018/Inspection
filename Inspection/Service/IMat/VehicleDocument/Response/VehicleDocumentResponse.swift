//
//  VehicleDecumentResponse.swift
//  Inspection
//
//  Created by Thanawat prathumset on 24/5/2564 BE.
//

import Foundation
import ObjectMapper

struct VehicleDocumentResponse : Mappable {
    
    
    /**
     {
     
            "documentID": 1,
            "vehicleId": "000000000001379851",
            "documentFile": "",
            "createUser": "Tester",
            "imageType": "JPG"
     }
     */
    
    var documentID:Int?
    var vehicleId:String?
    var documentFile:String?
    var createUser:String?
    var imageType:String?
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.documentID <- map["documentID"]
        self.vehicleId <- map["vehicleId"]
        self.documentFile <- map["documentFile"]
        self.createUser <- map["createUser"]
        self.imageType <- map["imageType"]
    }
    
    
}
