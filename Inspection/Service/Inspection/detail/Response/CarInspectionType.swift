/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct CarInspectionType : Mappable {
    
    var IMAT_NUMBER : String?
    
	var inspectionId : Int?
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

	mutating func mapping(map: Map) {
        
        IMAT_NUMBER <- map["IMAT_NUMBER"]
		inspectionId <- map["inspectionId"]
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
