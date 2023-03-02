/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct CabinType : Mappable {
	var cabinOverAllId : Int?
	var mileage : Int?
	var mileageTypeId : Int?
	var fuelVolumn : Int?
	var gearSystemId : Int?
	var isAirback : Bool = false
	var isHeadGear : Bool = false
	var isPowerAmp : Bool = false
	var isLockGear : Bool = false
	var isPreAmp : Bool = false
	var isBookService : Bool = false
	var isSpeaker : Bool = false
	var isManual : Bool = false
	var isCigaretteLiter : Bool = false
	var isTaxPlate : Bool = false
	var isPlateExpireDate : String = ""
	var isNavigator : Bool = false
	var isNavigatorBuiltin : Bool = false
	var isNavigatorCD : Bool = false
	var isNavigatorSDCard : Bool = false
	var isNavigatorNoCD : Bool = false
	var isNavigatorNoSDCard : Bool = false
	var playerBrand : String = ""
	var isPlayerRadio : Bool = false
	var isPlayerTape : Bool = false
	var isPlayerCD : Bool = false
	var isPlayerUSB : Bool = false
	var keyOptionId : Int?
	var cabinNote : String = ""

    var isInvalidMileage : Bool = false
    var invalidMileageReason : String = ""
    
	init?(map: Map) {

	}
    
    init(
        cabinOverAllId : Int?,
        mileage : Int?,
        mileageTypeId : Int?,
        fuelVolumn : Int?,
        gearSystemId : Int?,
        isAirback : Bool?,
        isHeadGear : Bool?,
        isPowerAmp : Bool?,
        isLockGear : Bool?,
        isPreAmp : Bool?,
        isBookService : Bool?,
        isSpeaker : Bool?,
        isManual : Bool?,
        isCigaretteLiter : Bool?,
        isTaxPlate : Bool?,
        isPlateExpireDate : String?,
        isNavigator : Bool?,
        isNavigatorBuiltin : Bool?,
        isNavigatorCD : Bool?,
        isNavigatorSDCard : Bool?,
        isNavigatorNoCD : Bool?,
        isNavigatorNoSDCard : Bool?,
        playerBrand : String?,
        isPlayerRadio : Bool?,
        isPlayerTape : Bool?,
        isPlayerCD : Bool?,
        isPlayerUSB : Bool?,
        keyOptionId : Int?,
        cabinNote : String?,
        isInvalidMileage : Bool?,
        invalidMileageReason : String?) {
        
        self.cabinOverAllId = cabinOverAllId
        self.mileage = mileage
        self.mileageTypeId = mileageTypeId
        self.fuelVolumn = fuelVolumn
        self.gearSystemId = gearSystemId
        self.isAirback = isAirback ?? false
        self.isHeadGear = isHeadGear ?? false
        self.isPowerAmp = isPowerAmp ?? false
        self.isLockGear = isLockGear ?? false
        self.isPreAmp = isPreAmp ?? false
        self.isBookService = isBookService ?? false
        self.isSpeaker = isSpeaker ?? false
        self.isManual = isManual ?? false
        self.isCigaretteLiter = isCigaretteLiter ?? false
        self.isTaxPlate = isTaxPlate ?? false
        self.isPlateExpireDate = isPlateExpireDate ?? ""
        self.isNavigator = isNavigator ?? false
        self.isNavigatorBuiltin = isNavigatorBuiltin ?? false
        self.isNavigatorCD = isNavigatorCD ?? false
        self.isNavigatorSDCard = isNavigatorSDCard ?? false
        self.isNavigatorNoCD = isNavigatorNoCD ?? false
        self.isNavigatorNoSDCard = isNavigatorNoSDCard ?? false
        self.playerBrand = playerBrand ?? ""
        self.isPlayerRadio = isPlayerRadio ?? false
        self.isPlayerTape = isPlayerTape ?? false
        self.isPlayerCD = isPlayerCD ?? false
        self.isPlayerUSB = isPlayerUSB ?? false
        self.keyOptionId = keyOptionId
        self.cabinNote = cabinNote ?? ""
        
        self.isInvalidMileage = isInvalidMileage ?? false
        self.invalidMileageReason = invalidMileageReason ?? ""
    }

	mutating func mapping(map: Map) {

		cabinOverAllId <- map["cabinOverAllId"]
		mileage <- map["mileage"]
		mileageTypeId <- map["mileageTypeId"]
		fuelVolumn <- map["fuelVolumn"]
		gearSystemId <- map["gearSystemId"]
		isAirback <- map["isAirback"]
		isHeadGear <- map["isHeadGear"]
		isPowerAmp <- map["isPowerAmp"]
		isLockGear <- map["isLockGear"]
		isPreAmp <- map["isPreAmp"]
		isBookService <- map["isBookService"]
		isSpeaker <- map["isSpeaker"]
		isManual <- map["isManual"]
		isCigaretteLiter <- map["isCigaretteLiter"]
		isTaxPlate <- map["isTaxPlate"]
		isPlateExpireDate <- map["isPlateExpireDate"]
		isNavigator <- map["isNavigator"]
		isNavigatorBuiltin <- map["isNavigatorBuiltin"]
		isNavigatorCD <- map["isNavigatorCD"]
		isNavigatorSDCard <- map["isNavigatorSDCard"]
		isNavigatorNoCD <- map["isNavigatorNoCD"]
		isNavigatorNoSDCard <- map["isNavigatorNoSDCard"]
		playerBrand <- map["playerBrand"]
		isPlayerRadio <- map["isPlayerRadio"]
		isPlayerTape <- map["isPlayerTape"]
		isPlayerCD <- map["isPlayerCD"]
		isPlayerUSB <- map["isPlayerUSB"]
        keyOptionId <- map["keyOptionId"]
		cabinNote <- map["cabinNote"]
        
        isInvalidMileage <- map["isInvalidMileage"]
        invalidMileageReason <- map["invalidMileageReason"]
	}

}
