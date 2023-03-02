//
//  VehicleDocumentRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 24/5/2564 BE.
//

import Foundation
import ObjectMapper

struct VehicleDocumentRequest :  Mappable {
    
    /**
     {
         
         "vehicleId" : "000000000001379851",
         "documentFile" : "QEA=",
         "createUser" : "Tester",
         "imageType" : "JPG",
         "documentTypeID" : 4,
         "documentDeleted" : false
     
            
     }
     */
    var vehicleId:String?
    var documentFile:String?
    var createUser:String?
    var imageType:String?
    var documentTypeID: Int?
    var documentDeleted:Bool?
    var documentDescription_BU:String?
    
    init?(map: Map) {
        
    }
    
    init(vehicleId:String?,
        documentFile:String?,
        createUser:String?,
        imageType:String?,
        documentTypeID:Int?,
        documentDeleted:Bool?,
        documentDescription_BU:String?) {
        
        
        self.vehicleId = vehicleId
        self.documentFile = documentFile
        self.createUser = createUser
        self.imageType = imageType
        self.documentTypeID = documentTypeID
        self.documentDeleted = documentDeleted
        self.documentDescription_BU = documentDescription_BU
    }
    
    mutating func mapping(map: Map) {
        self.vehicleId <- map["vehicleId"]
        self.documentFile <- map["documentFile"]
        self.createUser <- map["createUser"]
        self.imageType <- map["imageType"]
        self.documentTypeID <- map["documentTypeID"]
        self.documentDeleted <- map["documentDeleted"]
        self.documentDescription_BU <- map["documentDescription_BU"]
    }
    
    
}
