//
//  BookInMotorBikeModelRequest.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 7/10/2564 BE.
//

import Foundation
import ObjectMapper

struct BookInMotorBikeModelRequest : Mappable {
   
    var bookinNo:String?
    
    var bookInType : BookInType?
    var vehicleType : VehicleType?
    var externalType : ExternalType?
    var spareType : SpareType?
    var cabinType : CabinType?
    var engineType : EngineType?
    var keyOptionType : KeyOptionType?
    var motorbikeBookInType : MotorbikeBookInType?
    
    init?(map: Map) {
        
    }
    init(){
        
    }
    init(bookInType : BookInType,
         vehicleType : VehicleType,
         externalType : ExternalType,
         spareType : SpareType,
         cabinType : CabinType,
         engineType : EngineType,
         keyOptionType : KeyOptionType,
         motorbikeBookInType : MotorbikeBookInType,
         bookinNo : String? = nil) {
        
        self.bookInType = bookInType
        self.vehicleType = vehicleType
        self.externalType = externalType
        self.spareType = spareType
        self.cabinType = cabinType
        self.engineType = engineType
        self.keyOptionType = keyOptionType
        self.motorbikeBookInType = motorbikeBookInType
        
        self.bookinNo = bookinNo
        
    }
    mutating func mapping(map: Map) {
        bookInType <- map["bookInType"]
        vehicleType <- map["vehicleType"]
        externalType <- map["externalType"]
        spareType <- map["spareType"]
        cabinType <- map["cabinType"]
        engineType <- map["engineType"]
        keyOptionType <- map["keyOptionType"]
        motorbikeBookInType <- map["motorbikeBookInType"]
    }
    
    
    
}
