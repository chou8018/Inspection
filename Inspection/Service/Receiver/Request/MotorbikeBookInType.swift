//
//  MotorbikeBookInType.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 7/10/2564 BE.
//

import Foundation
import ObjectMapper

struct MotorbikeBookInType : Mappable {
    
    /**
     
         "motorbikeBookInType": {
                 "$id": "9",
                 "motorbikeBookinId": 5,
                 "frontWheelType": "ซี่ลวด",
                 "frontBrakeType": "ดิส",
                 "rearWheelType": "ซี่ลวด",
                 "rearBrakeType": "ดิส",
                 "rearTurnSignalR": "พอใช้",
                 "bodyCladdingR": "พอใช้",
                 "exhaustPipe": "พอใช้",
                 "rearFootRest": "พอใช้",
                 "starterLever": "พอใช้",
                 "frontFootRest": "พอใช้",
                 "sideStand": "พอใช้",
                 "doubleStand": "พอใช้",
                 "windScreenR": "พอใช้",
                 "multiPurposeR": "พอใช้",
                 "mirrorR": "พอใช้",
                 "handBreakR": "พอใช้",
                 "milesDisplay": "พอใช้",
                 "mask": "พอใช้",
                 "frontLight": "พอใช้",
                 "frontTurnSignalR": "พอใช้",
                 "frontFender": "พอใช้",
                 "frontTire": "พอใช้",
                 "frontPumpDiscBrake": "พอใช้",
                 "frontOilTankDiscBrake": "พอใช้",
                 "frontShockup": "พอใช้",
                 "chainCover": "พอใช้",
                 "handBreakL": "พอใช้",
                 "handClutch": "พอใช้",
                 "frontTurnSignalL": "พอใช้",
                 "mirrorL": "พอใช้",
                 "windScreenL": "พอใช้",
                 "bodyCladdingL": "พอใช้",
                 "seat": "พอใช้",
                 "rearSeatRack": "พอใช้",
                 "rearTurnSignalL": "พอใช้",
                 "rearLight": "พอใช้",
                 "rearFender": "พอใช้",
                 "multiPurposeL": "พอใช้",
                 "rearTire": "พอใช้",
                 "rearPumpDiscBrake": "พอใช้",
                 "rearOilTankDiscBrake": "พอใช้",
                 "rearShockup": "พอใช้",
                 "ubox": "พอใช้",
                 "oilTank": "พอใช้",
                 "battery": "พอใช้",
                 "cdiBox": "พอใช้",
                 "toolSpare": "พอใช้",
                 "frontWheel": "พอใช้",
                 "rearWheel": "พอใช้",
                 "frontBrake": "พอใช้",
                 "rearBrake": "พอใช้",
                 "otherNote": "NOTE NOTE",
                 "engineCondition": "สตาร์ทติด",
                 "gearCondition": "พอใช้",
                 "brakeCondition": "พอใช้",
                 "isHandStart": true,
                 "isKickStart": true,
                 "isRegistrationPlate": true,
                 "annotation": "annotation annotation",
                 "bookInNumber": "211006018 "
             }
     */
    
    var frontWheelType: String = ""
    var frontBrakeType: String = ""
    var rearWheelType: String = ""
    var rearBrakeType: String = ""
    var rearTurnSignalR: String = ""
    var bodyCladdingR: String = ""
    var exhaustPipe: String = ""
    var rearFootRest: String = ""
    var starterLever: String = ""
    var frontFootRest: String = ""
    var sideStand: String = ""
    var doubleStand: String = ""
    var windScreenR: String = ""
    var multiPurposeR: String = ""
    var mirrorR: String = ""
    var handBreakR: String = ""
    var milesDisplay: String = ""
    var mask: String = ""
    var frontLight: String = ""
    var frontTurnSignalR: String = ""
    var frontFender: String = ""
    var frontTire: String = ""
    var frontPumpDiscBrake: String = ""
    var frontOilTankDiscBrake: String = ""
    var frontShockup: String = ""
    var chainCover: String = ""
    var handBreakL: String = ""
    var handClutch: String = ""
    var frontTurnSignalL: String = ""
    var mirrorL: String = ""
    var windScreenL: String = ""
    var bodyCladdingL: String = ""
    var seat: String = ""
    var rearSeatRack: String = ""
    var rearTurnSignalL: String = ""
    var rearLight: String = ""
    var rearFender: String = ""
    var multiPurposeL: String = ""
    var rearTire: String = ""
    var rearPumpDiscBrake: String = ""
    var rearOilTankDiscBrake: String = ""
    var rearShockup: String = ""
    var ubox: String = ""
    var oilTank: String = ""
    var battery: String = ""
    var cdiBox: String = ""
    var toolSpare: String = ""
    var frontWheel: String = ""
    var rearWheel: String = ""
    var frontBrake: String = ""
    var rearBrake: String = ""
    var otherNote: String = ""
    var engineCondition: String = ""
    var gearCondition: String = ""
    var brakeCondition: String = ""
    var isHandStart: Bool = false
    var isKickStart: Bool = false
    var isRegistrationPlate: Bool = false
    var annotation: String = ""
    //var bookInNumber: String = ""
    
    
    init?(map: Map) {
        
    }
    
    init(frontWheelType: String?,
         frontBrakeType: String?,
         rearWheelType: String?,
         rearBrakeType: String?,
         rearTurnSignalR: String?,
         bodyCladdingR: String?,
         exhaustPipe: String?,
         rearFootRest: String?,
         starterLever: String?,
         frontFootRest: String?,
         sideStand: String?,
         doubleStand: String?,
         windScreenR: String?,
         multiPurposeR: String?,
         mirrorR: String?,
         handBreakR: String?,
         milesDisplay: String?,
         mask: String?,
         frontLight: String?,
         frontTurnSignalR: String?,
         frontFender: String?,
         frontTire: String?,
         frontPumpDiscBrake: String?,
         frontOilTankDiscBrake: String?,
         frontShockup: String?,
         chainCover: String?,
         handBreakL: String?,
         handClutch: String?,
         frontTurnSignalL: String?,
         mirrorL: String?,
         windScreenL: String?,
         bodyCladdingL: String?,
         seat: String?,
         rearSeatRack: String?,
         rearTurnSignalL: String?,
         rearLight: String?,
         rearFender: String?,
         multiPurposeL: String?,
         rearTire: String?,
         rearPumpDiscBrake: String?,
         rearOilTankDiscBrake: String?,
         rearShockup: String?,
         ubox: String?,
         oilTank: String?,
         battery: String?,
         cdiBox: String?,
         toolSpare: String?,
         frontWheel: String?,
         rearWheel: String?,
         frontBrake: String?,
         rearBrake: String?,
         otherNote: String?,
         engineCondition: String?,
         gearCondition: String?,
         brakeCondition: String?,
         isHandStart: Bool?,
         isKickStart: Bool?,
         isRegistrationPlate: Bool?,
         annotation: String?) {
         //bookInNumber: String?
        
        
            self.frontWheelType = frontWheelType ?? ""
            self.frontBrakeType = frontBrakeType ?? ""
            self.rearWheelType = rearWheelType ?? ""
            self.rearBrakeType = rearBrakeType ?? ""
            self.rearTurnSignalR = rearTurnSignalR ?? ""
            self.bodyCladdingR = bodyCladdingR ?? ""
            self.exhaustPipe = exhaustPipe ?? ""
            self.rearFootRest = rearFootRest ?? ""
            self.starterLever = starterLever ?? ""
            self.frontFootRest = frontFootRest ?? ""
            self.sideStand = sideStand ?? ""
            self.doubleStand = doubleStand ?? ""
            self.windScreenR = windScreenR ?? ""
            self.multiPurposeR = multiPurposeR ?? ""
            self.mirrorR = mirrorR ?? ""
            self.handBreakR = handBreakR ?? ""
            self.milesDisplay = milesDisplay ?? ""
            self.mask = mask ?? ""
            self.frontLight = frontLight ?? ""
            self.frontTurnSignalR = frontTurnSignalR ?? ""
            self.frontFender = frontFender ?? ""
            self.frontTire = frontTire ?? ""
            self.frontPumpDiscBrake = frontPumpDiscBrake ?? ""
            self.frontOilTankDiscBrake = frontOilTankDiscBrake ?? ""
            self.frontShockup = frontShockup ?? ""
            self.chainCover = chainCover ?? ""
            self.handBreakL = handBreakL ?? ""
            self.handClutch = handClutch ?? ""
            self.frontTurnSignalL = frontTurnSignalL ?? ""
            self.mirrorL = mirrorL ?? ""
            self.windScreenL = windScreenL ?? ""
            self.bodyCladdingL = bodyCladdingL ?? ""
            self.seat = seat ?? ""
            self.rearSeatRack = rearSeatRack ?? ""
            self.rearTurnSignalL = rearTurnSignalL ?? ""
            self.rearLight = rearLight ?? ""
            self.rearFender = rearFender ?? ""
            self.multiPurposeL = multiPurposeL ?? ""
            self.rearTire = rearTire ?? ""
            self.rearPumpDiscBrake = rearPumpDiscBrake ?? ""
            self.rearOilTankDiscBrake = rearOilTankDiscBrake ?? ""
            self.rearShockup = rearShockup ?? ""
            self.ubox = ubox ?? ""
            self.oilTank = oilTank ?? ""
            self.battery = battery ?? ""
            self.cdiBox = cdiBox ?? ""
            self.toolSpare = toolSpare ?? ""
            self.frontWheel = frontWheel ?? ""
            self.rearWheel = rearWheel ?? ""
            self.frontBrake = frontBrake ?? ""
            self.rearBrake = rearBrake ?? ""
            self.otherNote = otherNote ?? ""
            self.engineCondition = engineCondition ?? ""
            self.gearCondition = gearCondition ?? ""
            self.brakeCondition = brakeCondition ?? ""
            self.isHandStart = isHandStart ?? false
            self.isKickStart = isKickStart ?? false
            self.isRegistrationPlate = isRegistrationPlate ?? false
            self.annotation = annotation ?? ""
            //self.bookInNumber = bookInNumber ?? ""
    }
    mutating func mapping(map: Map) {
        frontWheelType <- map["frontWheelType"]
        frontBrakeType <- map["frontBrakeType"]
        rearWheelType <- map["rearWheelType"]
        rearBrakeType <- map["rearBrakeType"]
        rearTurnSignalR <- map["rearTurnSignalR"]
        bodyCladdingR <- map["bodyCladdingR"]
        exhaustPipe <- map["exhaustPipe"]
        rearFootRest <- map["rearFootRest"]
        starterLever <- map["starterLever"]
        frontFootRest <- map["frontFootRest"]
        sideStand <- map["sideStand"]
        doubleStand <- map["doubleStand"]
        windScreenR <- map["windScreenR"]
        multiPurposeR <- map["multiPurposeR"]
        mirrorR <- map["mirrorR"]
        handBreakR <- map["handBreakR"]
        milesDisplay <- map["milesDisplay"]
        mask <- map["mask"]
        frontLight <- map["frontLight"]
        frontTurnSignalR <- map["frontTurnSignalR"]
        frontFender <- map["frontFender"]
        frontTire <- map["frontTire"]
        frontPumpDiscBrake <- map["frontPumpDiscBrake"]
        frontOilTankDiscBrake <- map["frontOilTankDiscBrake"]
        frontShockup <- map["frontShockup"]
        chainCover <- map["chainCover"]
        handBreakL <- map["handBreakL"]
        handClutch <- map["handClutch"]
        frontTurnSignalL <- map["frontTurnSignalL"]
        mirrorL <- map["mirrorL"]
        windScreenL <- map["windScreenL"]
        bodyCladdingL <- map["bodyCladdingL"]
        seat <- map["seat"]
        rearSeatRack <- map["rearSeatRack"]
        rearTurnSignalL <- map["rearTurnSignalL"]
        rearLight <- map["rearLight"]
        rearFender <- map["rearFender"]
        multiPurposeL <- map["multiPurposeL"]
        rearTire <- map["rearTire"]
        rearPumpDiscBrake <- map["rearPumpDiscBrake"]
        rearOilTankDiscBrake <- map["rearOilTankDiscBrake"]
        rearShockup <- map["rearShockup"]
        ubox <- map["ubox"]
        oilTank <- map["oilTank"]
        battery <- map["battery"]
        cdiBox <- map["cdiBox"]
        toolSpare <- map["toolSpare"]
        frontWheel <- map["frontWheel"]
        rearWheel <- map["rearWheel"]
        frontBrake <- map["frontBrake"]
        rearBrake <- map["rearBrake"]
        otherNote <- map["otherNote"]
        engineCondition <- map["engineCondition"]
        gearCondition <- map["gearCondition"]
        brakeCondition <- map["brakeCondition"]
        isHandStart <- map["isHandStart"]
        isKickStart <- map["isKickStart"]
        isRegistrationPlate <- map["isRegistrationPlate"]
        annotation <- map["annotation"]
        //bookInNumber <- map["bookInNumber"]
    }
    
    
}
