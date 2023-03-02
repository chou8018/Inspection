//
//  ModelCodeTemplateModel.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import ObjectMapper

struct ModelCodeTemplateModel : Mappable {
    /**
     
         [
         {
                 "modelCode": "TFR87JEQN3",
                 "modelDisplay": "D-MAXSPACE CAB 1.9 L",
                 "buildYear": "2017",
                 "model_BU": "D-MAX",
                 "model_LO": "ดีแมคซ์",
                 "variants": "SPACE CAB 1.9 L",
                 "description_BU": "Isuzu 1900 CC Direct Injection Diesel Manual 6 speed Rear Wheel Drive Pick Up SPACE CAB 1.9 L",
                 "description_LO": "อีซูซุ 1900 CC อีซูซุ  ดีเซล ธรรมดา  6 เกียร์ ขับเคลื่อนล้อหลัง รถกระบะ SPACE CAB 1.9 L",
                 "engineCapacity": 1900.0,
                 "engineCapacityUnit": "CC",
                 "fuelDelivery": "D",
                 "fuelType": "D",
                 "gearbox": "M",
                 "gears": "6 ",
                 "drive": "R  ",
                 "make": "29",
                 "body": "A",
                 "createDate": "2021-07-06T09:52:24.133",
                 "createUser": "puttarawutb",
                 "chassisPreCode": "MP1TFR87JHT031461",
                 "id": 1420
             }
         ]
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
    var createDate: String?
    var createUser: String?
    var chassisPreCode: String?
    var id: Int?
    
    init?(map: Map) {
        
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
        self.createDate <- map["createDate"]
        self.createUser <- map["createUser"]
        self.chassisPreCode <- map["chassisPreCode"]
        self.id <- map["id"]
    }
    
    
}
