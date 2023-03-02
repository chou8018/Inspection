/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct EngineType : Mappable {
	var engineRoomOverAllId : Int?
    var driverSystemId : Int?
    var fuelSystemId : Int?
	var batteryBrand : String = ""
	var batteryIndicatorColor : String = ""
	var isEcu : Bool = false
	var isCompressorAir : Bool = false
	var isFuelGas : Bool = false
	var gasTypeId : Int = 0
	var insideAssetNote : String = ""

	init?(map: Map) {

	}
    
    init(
        engineRoomOverAllId : Int?,
        batteryBrand : String?,
        batteryIndicatorColor : String?,
        isEcu : Bool?,
        isCompressorAir : Bool?,
        driverSystemId : Int?,
        fuelSystemId : Int?,
        isFuelGas : Bool?,
        gasTypeId : Int?,
        insideAssetNote : String?){
        
        self.engineRoomOverAllId = engineRoomOverAllId
        self.batteryBrand = batteryBrand ?? ""
        self.batteryIndicatorColor = batteryIndicatorColor ?? ""
        self.isEcu = isEcu ?? false
        self.isCompressorAir = isCompressorAir ?? false
        self.driverSystemId = driverSystemId
        self.fuelSystemId = fuelSystemId
        self.isFuelGas = isFuelGas ?? false
        self.gasTypeId = gasTypeId ?? 0
        self.insideAssetNote = insideAssetNote ?? ""
        
    }

	mutating func mapping(map: Map) {

		engineRoomOverAllId <- map["engineRoomOverAllId"]
		batteryBrand <- map["batteryBrand"]
		batteryIndicatorColor <- map["batteryIndicatorColor"]
		isEcu <- map["isEcu"]
		isCompressorAir <- map["isCompressorAir"]
		driverSystemId <- map["driverSystemId"]
		fuelSystemId <- map["fuelSystemId"]
		isFuelGas <- map["isFuelGas"]
		gasTypeId <- map["gasTypeId"]
		insideAssetNote <- map["insideAssetNote"]
	}

}
