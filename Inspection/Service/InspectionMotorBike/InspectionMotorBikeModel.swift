//
//  InspectionMotorBikeModel.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 8/10/2564 BE.
//

import Foundation
import ObjectMapper

struct InspectionMotorBikeModel : Mappable {
    
    
    /**
            
        {
                 "bookInNumber": "sample string 2",
                 "vehicleId": "sample string 3",
                 "inspectorName": "sample string 4",
                 "inspectionDate": "sample string 5",
                 "inspector": "sample string 6",
                 "latestUpdatedDate": "sample string 7",
                 "registrationProvince": "sample string 8",
                 "registration": "sample string 9",
                 "exteriorDamage": "sample string 10",
                 "isBattery": true,
                 "batteryDamage": "sample string 11",
                 "isCDI": true,
                 "cdiDamage": "sample string 12",
                 "isElectricStart": true,
                 "electricStartDamage": "sample string 13",
                 "isOdometer": true,
                 "odometerDamage": "sample string 14",
                 "isPedelStart": true,
                 "pedelStartDamage": "sample string 15",
                 "isPlate": true,
                 "plateDamage": "sample string 16",
                 "frontTreadDepth": "sample string 17",
                 "rearTreadDepth": "sample string 18",
                 "fuelDeliveryType": "sample string 19",
                 "fuelDeliveryDamage": "sample string 20",
                 "isKey": true,
                 "isRemoteKey": true,
                 "isRemote": true,
                 "isImmobilizarKey": true,
                 "isServiceable": true,
                 "isWillNotStart": true,
                 "isRequireAttention": true,
                 "isMissing": true
        }
     */
    
    var bookInNumber: String = ""
    var vehicleId: String = ""
    var inspectorName: String = ""
    var inspectionDate: String = ""
    var inspector: String = ""
    var latestUpdatedDate: String = ""
    var registrationProvince: String = ""
    var registration: String = ""
    var exteriorDamage: String = ""
    var isBattery: Bool = false
    var batteryDamage: String = ""
    var isCDI: Bool = false
    var cdiDamage: String = ""
    var isElectricStart: Bool = false
    var electricStartDamage: String = ""
    var isOdometer: Bool = false
    var odometerDamage: String = ""
    var isPedelStart: Bool = false
    var pedelStartDamage: String = ""
    var isPlate: Bool = false
    var plateDamage: String = ""
    var frontTreadDepth: String = ""
    var rearTreadDepth: String = ""
    var fuelDeliveryType: String = ""
    var fuelDeliveryDamage: String = ""
    var isKey: Bool = false
    var isRemoteKey:Bool = false
    var isRemote:Bool = false
    var isImmobilizarKey: Bool = false
    var isServiceable: Bool = false
    var isWillNotStart: Bool = false
    var isRequireAttention: Bool = false
    var isMissing: Bool = false
    
    
    init?(map: Map) {
     
    }
    
    init(bookInNumber: String?,
         vehicleId: String?,
         inspectorName: String?,
         inspectionDate: String?,
         inspector: String?,
         latestUpdatedDate: String?,
         registrationProvince: String?,
         registration: String?,
         exteriorDamage: String?,
         isBattery: Bool?,
         batteryDamage: String?,
         isCDI: Bool?,
         cdiDamage: String?,
         isElectricStart: Bool?,
         electricStartDamage: String?,
         isOdometer: Bool?,
         odometerDamage: String?,
         isPedelStart: Bool?,
         pedelStartDamage: String?,
         isPlate: Bool?,
         plateDamage: String?,
         frontTreadDepth: String?,
         rearTreadDepth: String?,
         fuelDeliveryType: String?,
         fuelDeliveryDamage: String?,
         isKey: Bool?,
         isRemoteKey:Bool?,
         isRemote:Bool?,
         isImmobilizarKey: Bool?,
         isServiceable: Bool?,
         isWillNotStart: Bool?,
         isRequireAttention: Bool?,
         isMissing: Bool?){
        
        
        self.bookInNumber = bookInNumber ?? ""
        self.vehicleId = vehicleId ?? ""
        self.inspectorName = inspectorName ?? ""
        self.inspectionDate = inspectionDate ?? ""
        self.inspector = inspector ?? ""
        self.latestUpdatedDate = latestUpdatedDate ?? ""
        self.registrationProvince = registrationProvince ?? ""
        self.registration = registration ?? ""
        self.exteriorDamage = exteriorDamage ?? ""
        self.isBattery = isBattery ?? false
        self.batteryDamage = batteryDamage ?? ""
        self.isCDI = isCDI ?? false
        self.cdiDamage = cdiDamage ?? ""
        self.isElectricStart = isElectricStart ?? false
        self.electricStartDamage = electricStartDamage ?? ""
        self.isOdometer = isOdometer ?? false
        self.odometerDamage = odometerDamage ?? ""
        self.isPedelStart = isPedelStart ?? false
        self.pedelStartDamage = pedelStartDamage ?? ""
        self.isPlate = isPlate ?? false
        self.plateDamage = plateDamage ?? ""
        self.frontTreadDepth = frontTreadDepth ?? ""
        self.rearTreadDepth = rearTreadDepth ?? ""
        self.fuelDeliveryType = fuelDeliveryType ?? ""
        self.fuelDeliveryDamage = fuelDeliveryDamage ?? ""
        self.isKey = isKey ?? false
        self.isRemoteKey = isRemoteKey ?? false
        self.isRemote = isRemote ?? false
        self.isImmobilizarKey = isImmobilizarKey ?? false
        self.isServiceable = isServiceable ?? false
        self.isWillNotStart = isWillNotStart ?? false
        self.isRequireAttention = isRequireAttention ?? false
        self.isMissing = isMissing ?? false
    }
    mutating func mapping(map: Map) {
        
        bookInNumber <- map["bookInNumber"]
        vehicleId <- map["vehicleId"]
        inspectorName <- map["inspectorName"]
        inspectionDate <- map["inspectionDate"]
        inspector <- map["inspector"]
        latestUpdatedDate <- map["latestUpdatedDate"]
        registrationProvince <- map["registrationProvince"]
        registration <- map["registration"]
        exteriorDamage <- map["exteriorDamage"]
        isBattery <- map["isBattery"]
        batteryDamage <- map["batteryDamage"]
        isCDI <- map["isCDI"]
        cdiDamage <- map["cdiDamage"]
        isElectricStart <- map["isElectricStart"]
        electricStartDamage <- map["electricStartDamage"]
        isOdometer <- map["isOdometer"]
        odometerDamage <- map["odometerDamage"]
        isPedelStart <- map["isPedelStart"]
        pedelStartDamage <- map["pedelStartDamage"]
        isPlate <- map["isPlate"]
        plateDamage <- map["plateDamage"]
        frontTreadDepth <- map["frontTreadDepth"]
        rearTreadDepth <- map["rearTreadDepth"]
        fuelDeliveryType <- map["fuelDeliveryType"]
        fuelDeliveryDamage <- map["fuelDeliveryDamage"]
        isKey <- map["isKey"]
        isRemoteKey <- map["isRemoteKey"]
        isRemote <- map["isRemote"]
        isImmobilizarKey <- map["isImmobilizarKey"]
        isServiceable <- map["isServiceable"]
        isWillNotStart <- map["isWillNotStart"]
        isRequireAttention <- map["isRequireAttention"]
        isMissing <- map["isMissing"]
    }
    
    
}
