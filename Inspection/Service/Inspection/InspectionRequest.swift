//
//  InspectionRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 21/4/2564 BE.
//

import Foundation
import ObjectMapper

struct InspectionRequest : Mappable {
    
    
    var vehicleId : String?
    var inspector : String?
    var inspectorName: String?
    var inspectionDate : String?
    var chassis : String?
    var front : String?
    var back : String?
    var rightSide : String?
    var leftSide : String?
    var roof : String?
    var isFlood : Bool?
    var bodySummary : String?
    var isEngineWorks : Bool?
    var fuelSystemId : Int?
    var isLubricatorLow : Bool?
    var engineSystemId : Int?
    var gearTypeId : Int?
    var isUseableGeneral : Bool?
    var isSoundAbnormal : Bool?
    var isLeakFuel : Bool?
    var isStainWater : Bool?
    var isMachineLightShow : Bool?
    var isEngineAbnomal : Bool?
    var isNeedRepair : Bool?
    var engineSummary : String?
    var driveShaftConditionId : Int?
    var driveShaftConditionNote : String?
    var suspensionConditionId : Int?
    var suspensionConditionNote : String?
    var suspensionSummary : String?
    var gearSystemId : Int?
    var gearConditionId : Int?
    var driveShaftId : Int?
    var is4WD : Bool?
    var gearSystemSummary : String?
    var isUseableSteerWheel : Bool?
    var isPowerSteering : Bool?
    var steeringSummary : String?
    var isUseableBrake : Bool?
    var breakSystemSumary : String?
    var isAirCool : Bool?
    var isCompressorAir : Bool?
    var airSystemSummary : String?
    var isUseableGuage : Bool?
    var warningLightNote : String?
    var gaugeSummary : String?
    var isFrontLightWorking : Bool?
    var isTurnLightWorking : Bool?
    var isBackLightWorking : Bool?
    var isBrakeLightWoring : Bool?
    var isBetteryWorking : Bool?
    var isHooterWorking : Bool?
    var isRoundGaugeWorking : Bool?
    var isNavigator : Bool?
    var isNavigatorBuiltIn : Bool?
    var isNavigatorCD : Bool?
    var isNavigatorSdcard : Bool?
    var isNavigatorNoCD : Bool?
    var isNavigatorNoSdcard : Bool?
    var electronicNote : String?
    var electronicSummary : String?
    var bookInNumber : String?
    var latestUpdatedDate : String?
    
    var registrationProvince: String?
    var regisration: String?
    
    init?(map: Map) {

    }

    
    init(
        vehicleId : String?,
        inspector : String?,
        inspectorName : String?,
        inspectionDate : String?,
        chassis : String?,
        front : String?,
        back : String?,
        rightSide : String?,
        leftSide : String?,
        roof : String?,
        isFlood : Bool?,
        bodySummary : String?,
        isEngineWorks : Bool?,
        fuelSystemId : Int?,
        isLubricatorLow : Bool?,
        engineSystemId : Int?,
        gearTypeId : Int?,
        isUseableGeneral : Bool?,
        isSoundAbnormal : Bool?,
        isLeakFuel : Bool?,
        isStainWater : Bool?,
        isMachineLightShow : Bool?,
        isEngineAbnomal : Bool?,
        isNeedRepair : Bool?,
        engineSummary : String?,
        driveShaftConditionId : Int?,
        driveShaftConditionNote : String?,
        suspensionConditionId : Int?,
        suspensionConditionNote : String?,
        suspensionSummary : String?,
        gearSystemId : Int?,
        gearConditionId : Int?,
        driveShaftId : Int?,
        is4WD : Bool?,
        gearSystemSummary : String?,
        isUseableSteerWheel : Bool?,
        isPowerSteering : Bool?,
        steeringSummary : String?,
        isUseableBrake : Bool?,
        breakSystemSumary : String?,
        isAirCool : Bool?,
        isCompressorAir : Bool?,
        airSystemSummary : String?,
        isUseableGuage : Bool?,
        warningLightNote : String?,
        gaugeSummary : String?,
        isFrontLightWorking : Bool?,
        isTurnLightWorking : Bool?,
        isBackLightWorking : Bool?,
        isBrakeLightWoring : Bool?,
        isBetteryWorking : Bool?,
        isHooterWorking : Bool?,
        isRoundGaugeWorking : Bool?,
        isNavigator : Bool?,
        isNavigatorBuiltIn : Bool?,
        isNavigatorCD : Bool?,
        isNavigatorSdcard : Bool?,
        isNavigatorNoCD : Bool?,
        isNavigatorNoSdcard : Bool?,
        electronicNote : String?,
        electronicSummary : String?,
        bookInNumber : String?,
        latestUpdatedDate : String?,
        registrationProvince: String?,
        regisration: String?) {
        
      
        self.vehicleId = vehicleId
        self.inspector = inspector ?? ""
        self.inspectorName = inspectorName ?? ""
        self.inspectionDate = inspectionDate ?? ""
        self.chassis = chassis ?? ""
        self.front = front ?? ""
        self.back = back ?? ""
        self.rightSide = rightSide ?? ""
        self.leftSide = leftSide ?? ""
        self.roof = roof ?? ""
        self.isFlood = isFlood ?? false
        self.bodySummary = bodySummary ?? ""
        self.isEngineWorks = isEngineWorks ?? false
        self.fuelSystemId = fuelSystemId ?? 0
        self.isLubricatorLow = isLubricatorLow ?? false
        self.engineSystemId = engineSystemId ?? 0
        self.gearTypeId = gearTypeId ?? 0
        self.isUseableGeneral = isUseableGeneral ?? false
        self.isSoundAbnormal = isSoundAbnormal ?? false
        self.isLeakFuel = isLeakFuel ?? false
        self.isStainWater = isStainWater ?? false
        self.isMachineLightShow = isMachineLightShow ?? false
        self.isEngineAbnomal = isEngineAbnomal ?? false
        self.isNeedRepair = isNeedRepair ?? false
        self.engineSummary = engineSummary ?? ""
        self.driveShaftConditionId = driveShaftConditionId ?? 0
        self.driveShaftConditionNote = driveShaftConditionNote ?? ""
        self.suspensionConditionId = suspensionConditionId ?? 0
        self.suspensionConditionNote = suspensionConditionNote ?? ""
        self.suspensionSummary = suspensionSummary ?? ""
        self.gearSystemId = gearSystemId ?? 0
        self.gearConditionId = gearConditionId ?? 0
        self.driveShaftId = driveShaftId ?? 0
        self.is4WD = is4WD ?? false
        self.gearSystemSummary = gearSystemSummary ?? ""
        self.isUseableSteerWheel = isUseableSteerWheel ?? false
        self.isPowerSteering = isPowerSteering ?? false
        self.steeringSummary = steeringSummary ?? ""
        self.isUseableBrake = isUseableBrake ?? false
        self.breakSystemSumary = breakSystemSumary ?? ""
        self.isAirCool = isAirCool ?? false
        self.isCompressorAir = isCompressorAir ?? false
        self.airSystemSummary = airSystemSummary ?? ""
        self.isUseableGuage = isUseableGuage ?? false
        self.warningLightNote = warningLightNote ?? ""
        self.gaugeSummary = gaugeSummary ?? ""
        self.isFrontLightWorking = isFrontLightWorking ?? false
        self.isTurnLightWorking = isTurnLightWorking ?? false
        self.isBackLightWorking = isBackLightWorking ?? false
        self.isBrakeLightWoring = isBrakeLightWoring ?? false
        self.isBetteryWorking = isBetteryWorking ?? false
        self.isHooterWorking = isHooterWorking ?? false
        self.isRoundGaugeWorking = isRoundGaugeWorking ?? false
        self.isNavigator = isNavigator ?? false
        self.isNavigatorBuiltIn = isNavigatorBuiltIn ?? false
        self.isNavigatorCD = isNavigatorCD ?? false
        self.isNavigatorSdcard = isNavigatorSdcard ?? false
        self.isNavigatorNoCD = isNavigatorNoCD ?? false
        self.isNavigatorNoSdcard = isNavigatorNoSdcard ?? false
        self.electronicNote = electronicNote ?? ""
        self.electronicSummary = electronicSummary ?? ""
        self.bookInNumber = bookInNumber ?? ""
        self.latestUpdatedDate = latestUpdatedDate ?? ""
        
        self.registrationProvince = registrationProvince ?? ""
        self.regisration = regisration ?? ""
    }
    mutating func mapping(map: Map) {

     
        vehicleId <- map["vehicleId"]
        inspector <- map["inspector"]
        inspectorName <- map["inspectorName"]
        inspectionDate <- map["inspectionDate"]
        chassis <- map["chassis"]
        front <- map["front"]
        back <- map["back"]
        rightSide <- map["rightSide"]
        leftSide <- map["leftSide"]
        roof <- map["roof"]
        isFlood <- map["isFlood"]
        bodySummary <- map["bodySummary"]
        isEngineWorks <- map["isEngineWorks"]
        fuelSystemId <- map["fuelSystemId"]
        isLubricatorLow <- map["isLubricatorLow"]
        engineSystemId <- map["engineSystemId"]
        gearTypeId <- map["gearTypeId"]
        isUseableGeneral <- map["isUseableGeneral"]
        isSoundAbnormal <- map["isSoundAbnormal"]
        isLeakFuel <- map["isLeakFuel"]
        isStainWater <- map["isStainWater"]
        isMachineLightShow <- map["isMachineLightShow"]
        isEngineAbnomal <- map["isEngineAbnomal"]
        isNeedRepair <- map["isNeedRepair"]
        engineSummary <- map["engineSummary"]
        driveShaftConditionId <- map["driveShaftConditionId"]
        driveShaftConditionNote <- map["driveShaftConditionNote"]
        suspensionConditionId <- map["suspensionConditionId"]
        suspensionConditionNote <- map["suspensionConditionNote"]
        suspensionSummary <- map["suspensionSummary"]
        gearSystemId <- map["gearSystemId"]
        gearConditionId <- map["gearConditionId"]
        driveShaftId <- map["driveShaftId"]
        is4WD <- map["is4WD"]
        gearSystemSummary <- map["gearSystemSummary"]
        isUseableSteerWheel <- map["isUseableSteerWheel"]
        isPowerSteering <- map["isPowerSteering"]
        steeringSummary <- map["steeringSummary"]
        isUseableBrake <- map["isUseableBrake"]
        breakSystemSumary <- map["breakSystemSumary"]
        isAirCool <- map["isAirCool"]
        isCompressorAir <- map["isCompressorAir"]
        airSystemSummary <- map["airSystemSummary"]
        isUseableGuage <- map["isUseableGuage"]
        warningLightNote <- map["warningLightNote"]
        gaugeSummary <- map["gaugeSummary"]
        isFrontLightWorking <- map["isFrontLightWorking"]
        isTurnLightWorking <- map["isTurnLightWorking"]
        isBackLightWorking <- map["isBackLightWorking"]
        isBrakeLightWoring <- map["isBrakeLightWoring"]
        isBetteryWorking <- map["isBetteryWorking"]
        isHooterWorking <- map["isHooterWorking"]
        isRoundGaugeWorking <- map["isRoundGaugeWorking"]
        isNavigator <- map["isNavigator"]
        isNavigatorBuiltIn <- map["isNavigatorBuiltIn"]
        isNavigatorCD <- map["isNavigatorCD"]
        isNavigatorSdcard <- map["isNavigatorSdcard"]
        isNavigatorNoCD <- map["isNavigatorNoCD"]
        isNavigatorNoSdcard <- map["isNavigatorNoSdcard"]
        electronicNote <- map["electronicNote"]
        electronicSummary <- map["electronicSummary"]
        bookInNumber <- map["bookInNumber"]
        latestUpdatedDate <- map["latestUpdatedDate"]
        
        registrationProvince <- map["registrationProvince"]
        regisration <- map["regisration"]
    }
    
}
