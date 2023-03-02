//
//  VehicleModelRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 18/5/2564 BE.
//

import Foundation
import ObjectMapper

struct VehicleModelRequest : Mappable {
    
    /**
     {
     BookInNumber
         VehicleId : [empty]
         Seller: [value]
         SellingCategory : [empty]
         LogisticsStatus : [value]
         SalesStatus : [value]
         Plant : [value]
         Make: [value]
         BookedDate
         EngineCapacityUnit
         Body
         Gearbox
         Gears
         FuelType
         FuelDelivery
         Colour_BU
         Colour_LO
         EngineCapacity
        createUser
     }
     */
    var bookInNumber:String?
    var vehicleId: String?
//    var sellingCategory:String?
//    
//    var seller:String?
//    var logisticsStatus:String?
//    var salesStatus:String?
//    var plant:String?
//    var make:String?
//    
//    var bookedDate:String?
//    var engineCapacityUnit:String?
//    var body:String?
//    var gearbox:String?
//    var gears:String?
//    var fuelType:String?
//    var fuelDelivery:String?
//    var colour_BU:String?
//    var colour_LO:String?
//    var engineCapacity:Int?
//    var createUser:String?
    
    init?(map: Map) {
        
    }
    init(
    bookInNumber: String?,
    vehicleId: String?
//    sellingCategory:String?,
//    seller:String?,
//    logisticsStatus:String?,
//    salesStatus:String?,
//    plant:String?,
//    make:String?,
//    bookedDate:String?,
//    engineCapacityUnit:String?,
//    body:String?,
//    gearbox:String?,
//    gears:String?,
//    fuelType:String?,
//    fuelDelivery:String?,
//    colour_BU:String?,
//    colour_LO:String?,
//    engineCapacity:Int?,
//    createUser:String?)
    ){
        
        self.bookInNumber = bookInNumber
        self.vehicleId = vehicleId
//        self.sellingCategory = sellingCategory
//        self.seller = seller
//        self.logisticsStatus = logisticsStatus
//        self.salesStatus = salesStatus
//        self.plant = plant
//        self.make = make
//
//        self.bookedDate = bookedDate
//        self.engineCapacityUnit = engineCapacityUnit
//        self.body = body
//        self.gearbox = gearbox
//        self.gears = gears
//        self.fuelType = fuelType
//        self.fuelDelivery = fuelDelivery
//        self.colour_BU = colour_BU
//        self.colour_LO = colour_LO
//        self.engineCapacity = engineCapacity
//        self.createUser = createUser
    }
    
    mutating func mapping(map: Map) {
        self.bookInNumber <- map["bookInNumber"]
        self.vehicleId <- map["vehicleId"]
//        self.sellingCategory <- map["sellingCategory"]
//        self.seller <- map["seller"]
//        self.logisticsStatus <- map["logisticsStatus"]
//        self.salesStatus <- map["salesStatus"]
//        self.plant <- map["plant"]
//        self.make <- map["make"]
//        self.bookedDate <- map["bookedDate"]
//        self.engineCapacityUnit <- map["engineCapacityUnit"]
//        self.body <- map["body"]
//        self.gearbox <- map["gearbox"]
//        self.gears <- map["gears"]
//        self.fuelType <- map["fuelType"]
//        self.fuelDelivery <- map["fuelDelivery"]
//        self.colour_BU <- map["colour_BU"]
//        self.colour_LO <- map["colour_LO"]
//        self.engineCapacity <- map["engineCapacity"]
//        self.createUser <- map["createUser"]
    }
    
    
}
