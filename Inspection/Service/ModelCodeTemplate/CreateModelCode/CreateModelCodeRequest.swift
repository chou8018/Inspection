//
//  CreateModelCodeRequest.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import ObjectMapper

struct CreateModelCodeRequest : Mappable {
    /**
     
         {
          "modelCode": "TEST123456789001",
          "modelDisplay": "TEST123456789001",
          "buildYear": "2021",
          "model_BU": "sample string 4",
          "model_LO": "sample string 5",
          "variants": "sample string 6",
          "description_BU": "sample string 7",
          "description_LO": "sample string 8",
          "engineCapacity": 2000,
          "engineCapacityUnit": "CC",
          "fuelDelivery": "I",
          "fuelType": "P",
          "gearbox": "A",
          "gears": "4",
          "drive": "F",
          "make": "45",
          "body": "S",
          "createUser": "Tester",
          "chassisPreCode": "CHASSISPRECODE"
         }
     */
    var modelCode: String?
    var modelDisplay: String?
    var buildYear: String?
    var model_BU: String?
    var model_LO: String?
    var variants: String?
    var description_BU: String?
    var description_LO: String?
    var engineCapacity: Int?
    var engineCapacityUnit: String?
    var fuelDelivery: String?
    var fuelType: String?
    var gearbox: String?
    var gears: String?
    var drive: String?
    var make: String?
    var body: String?
    var createUser: String?
    var chassisPreCode: String?
    var id: Int?
    
    init?(map: Map) {
        
    }
    init(
        modelCode: String?,
        modelDisplay: String?,
        buildYear: String?,
        model_BU: String?,
        model_LO: String?,
        variants: String?,
        description_BU: String?,
        description_LO: String?,
        engineCapacity: Int?,
        engineCapacityUnit: String?,
        fuelDelivery: String?,
        fuelType: String?,
        gearbox: String?,
        gears: String?,
        drive: String?,
        make: String?,
        body: String?,
        createUser: String?,
        chassisPreCode: String?,
        id: Int?) {
        
        
        self.modelCode = modelCode
        self.modelDisplay = modelDisplay
        self.buildYear = buildYear
        self.model_BU = model_BU
        self.model_LO = model_LO
        self.variants = variants
        self.description_BU = description_BU
        self.description_LO = description_LO
        self.engineCapacity = engineCapacity
        self.engineCapacityUnit = engineCapacityUnit
        self.fuelDelivery = fuelDelivery
        self.fuelType = fuelType
        self.gearbox = gearbox
        self.gears = gears
        self.drive = drive
        self.make = make
        self.body = body
        self.createUser = createUser
        self.chassisPreCode = chassisPreCode
        self.id = id
    }
    mutating func mapping(map: Map) {
        self.modelCode <- map["modelCode"]
        self.modelDisplay <- map["modelDisplay"]
        self.buildYear <- map["buildYear"]
        self.model_BU <- map["model_BU"]
        self.model_LO <- map["model_LO"]
        self.variants <- map["variants"]
        self.description_BU <- map["description_BU"]
        self.description_LO <- map["description_LO"]
        self.engineCapacity <- map["engineCapacity"]
        self.engineCapacityUnit <- map["engineCapacityUnit"]
        self.fuelDelivery <- map["fuelDelivery"]
        self.fuelType <- map["fuelType"]
        self.gearbox <- map["gearbox"]
        self.gears <- map["gears"]
        self.drive <- map["drive"]
        self.make <- map["make"]
        self.body <- map["body"]
        self.createUser <- map["createUser"]
        self.chassisPreCode <- map["chassisPreCode"]
        self.id <- map["id"]
    }
    
    
}
