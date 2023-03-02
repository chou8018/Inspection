//
//  MakeVehicleResponse.swift
//  Inspection
//
//  Created by Thanawat prathumset on 20/5/2564 BE.
//

import Foundation
import ObjectMapper

struct MakeVehicleResponse : Mappable {
    /**
     {
     
         "vehicleId": "000000000001379835",
         "seller": "0000100000",
         "sellingCategory": "CA",
         "logisticsStatus": "",
         "salesStatus": "NA",
         "plant": "TH10",
         "make": "61",
         "bookedDate": "0001-01-01T00:00:00",
         "engineCapacityUnit": null,
         "body": null,
         "gearbox": null,
         "gears": null,
         "fuelType": null,
         "fuelDelivery": null,
         "colour_BU": null,
         "colour_LO": null,
         "engineCapacity": null
     }
     */
    var vehicleId: String?
    var sellingCategory:String?
    var seller:String?
    var logisticsStatus:String?
    var salesStatus:String?
    var plant:String?
    var make:String?
    var bookedDate:String?
    var engineCapacityUnit:String?
    var body:String?
    var gearbox:String?
    var gears:String?
    var fuelType:String?
    var fuelDelivery:String?
    var colour_BU:String?
    var colour_LO:String?
    var engineCapacity:Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.vehicleId <- map["vehicleId"]
        self.sellingCategory <- map["sellingCategory"]
        self.seller <- map["seller"]
        self.logisticsStatus <- map["logisticsStatus"]
        self.salesStatus <- map["salesStatus"]
        self.plant <- map["plant"]
        self.make <- map["make"]
        self.bookedDate <- map["bookedDate"]
        self.engineCapacityUnit <- map["engineCapacityUnit"]
        self.body <- map["body"]
        self.gearbox <- map["gearbox"]
        self.gears <- map["gears"]
        self.fuelType <- map["fuelType"]
        self.fuelDelivery <- map["fuelDelivery"]
        self.colour_BU <- map["colour_BU"]
        self.colour_LO <- map["colour_LO"]
        self.engineCapacity <- map["engineCapacity"]
    }
    
    
}
