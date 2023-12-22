//
//  InspectionCar.swift
//  Inspection
//
//  Created by Thanawat prathumset on 17/2/2564 BE.
//

import Foundation

class InspectionCarModel {
    
    var isCreate = false /// check from get inspection from bookinNo
    var inspector : String? /// edited by
    var nameInspection : String?  /// created by
    var date : Date?
    var latestUpdatedDate : Date?
    var dayString : String?
    var timeString : String?
    
    //MARK: Body Inspection
    var chessis: String?
    var frontSide:  String?
    var backSide:  String?
    var rightSideDriver:  String?
    var leftSide:  String?
    var roof:  String?
    var isDrowned = false
    var bodySummary:  String?
    
    //MARK: Engine Inspection
    var engineOverall: String?
    var isEngineWorks : Bool? /// send to server
    
    var typeEngine: String?
    var engineSystemId:Int? /// send to server
    
    var oilEngine: String?
    var isLubricatorLow : Bool? /// send to server
    
    var fuelSystem: String?
    var fuelSystemId : Int? /// send to server
    
    var gasSystem: String?
    var gasTypeId: Int? /// send to server
    
    var useableGeneral = false
    var soundAbnormalGeneral = false
    var leakFuelGeneral = false
    var stainWaterGeneral = false
    var machineLightShowGeneral = false
    var engineAbnormalGeneral = false
    var needRepairGeneral = false
    var summaryEngine: String?
    
    //MARK: Under Inspection
    var summaryUnderCarriage : String?
    
    var underCarriage: String?
    var suspensionConditionId : Int? /// send to server
    
    var underCarriageNoteOther: String?
    
    var driveShaft: String?
    var driveShaftConditionId : Int? /// send to server
    
    var driveShaftNoteOther: String?
    
    //MARK: GearSystem Inspection
    var gearSystem: String?
    var gearSystemId : Int? /// send to server
    
    var statusGear: String?
    var gearConditionId: Int? /// send to server
    
    var driveShaftGear: String?
    var driveShaftId: Int? /// send to server
        
    var isGear4WD = false
    var summaryGearSystem: String?
    
    //MARK: SteerWheel
    var isSteerWheelPower = false
    
    var steerWheelSystem: String?
    var isUseableSteerWheel: Bool? /// send to server
    
    var summarySteerWheelSystem: String?
    
    
    //MARK: BrakeCheck
    var summarysBrakeSystem: String?
    
    var brakeSystem : String?
    var isUseableBrake : Bool? /// send to server
    
    //MARK: AirCheck
    var summaryAirSystem : String?
    var isCompresser = false
    
    var airSystem : String?
    var isAirCool : Bool? /// send to server
    
    //MARK: GaugeCheck
    var gaugeSystem: String?
    var isUseableGuage : Bool? /// send to server
    
    var summaryGaugeSystem: String?
    var machineLightShow: String?
    
    //MARK: ElectronicDevice
    var summaryElectronicDevice: String?
    var note: String?
    var isFrontLight = false
    var isTurnLight = false
    var isBackLight = false
    var isBrakeLight = false
    var isBettery = false
    var isHooter = false
    var isRoundGauge = false
    var isNavigator = false
    var isNavigatorOnCar = false
    var isCd = false
    var isSDCard = false
    var isNoSdCard = false
    var isNoCd = false
    
    // add 26/10/23
    var isSideMirror1 = false
    var isSideMirror2 = false
    var isSideMirror3 = false
    var isSideMirror4 = false
    var catalytic: String?
    var catalyticOptionId: Int?

    var registrationProvince: String?
    var registration: String?
    
    //MARK: MotorBike
    var exteriorDamage: String?
    var isBattery: Bool?
    var batteryDamage: String?
    var isCDI: Bool?
    var cdiDamage: String?
    var isElectricStart: Bool?
    var electricStartDamage: String?
    var isOdometer: Bool?
    var odometerDamage: String?
    var fuelDeliveryType: String?
    var fuelDeliveryDamage: String?
    var isPedelStart: Bool?
    var pedelStartDamage: String?
    var isPlate: Bool?
    var plateDamage: String?
    var frontTreadDepth: String?
    var rearTreadDepth: String?
    var isKey: Bool?
    var isRemoteKey: Bool?
    var isRemote: Bool?
    var isImmobilizarKey: Bool?
    var isServiceable: Bool?
    var isWillNotStart: Bool?
    var isRequireAttention: Bool?
    var isMissing: Bool?
    
    
    
    var grade:String?
    // exellence
    var e1Chehck : Bool = false
    var e2Chehck : Bool = false
    var e3Chehck : Bool = false
    var e4Chehck : Bool = false
    var e5Chehck : Bool = false
    
    // good
    var g1Chehck : Bool = false
    var g2Chehck : Bool = false
    var g3Chehck : Bool = false
    var g4Chehck : Bool = false
    
    // average
    var a1Chehck : Bool = false
    var a2Chehck : Bool = false
    var a3Chehck : Bool = false
    var a4Chehck : Bool = false
    
    // fair
    var f1Chehck : Bool = false
    var f2Chehck : Bool = false
    var f3Chehck : Bool = false
    var f4Chehck : Bool = false
    var f5Chehck : Bool = false
    var f6Chehck : Bool = false
    var f7Chehck : Bool = false
    var f8Chehck : Bool = false
    var f9Chehck : Bool = false
    var f10Chehck :Bool = false
    var f11Chehck :Bool = false
    
    // poor
    var p1Chehck : Bool = false
    var p2Chehck : Bool = false
    var p3Chehck : Bool = false
    var p4Chehck : Bool = false
    var p5Chehck : Bool = false
    var p6Chehck : Bool = false
    var p7Chehck : Bool = false
    var p8Chehck : Bool = false
    var p9Chehck : Bool = false
    
    // x
    var x1Chehck : Bool = false
    
    // y
    var y1Chehck : Bool = false
    
    // roof type and gas
    var roofType: String?
    var roofTypeId: Int?
    var gasOptions: String?
    
    var description : [String : Any]  {
        return [:]
    }
}
