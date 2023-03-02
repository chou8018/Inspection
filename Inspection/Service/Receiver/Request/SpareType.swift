/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct SpareType : Mappable {
	var spareOverAllId : Int?
	var spareNote : String = ""
	var isSpareType : Bool = false
	var isHandTool : Bool = false
	var isMaxliner : Bool = false
	var isRoofRack : Bool = false
	var isJackCar : Bool = false
	var isCableChargeEV : Bool = false
	var accessoriesNote : String = ""

	init?(map: Map) {

	}
    init(
         spareOverAllId : Int?,
         spareNote : String?,
         isSpareType : Bool?,
         isHandTool : Bool?,
         isMaxliner : Bool?,
         isRoofRack : Bool?,
         isJackCar : Bool?,
         isCableChargeEV : Bool?,
         accessoriesNote : String?){
        
        
        self.spareOverAllId = spareOverAllId
        self.spareNote = spareNote ?? ""
        self.isSpareType = isSpareType ?? false
        self.isHandTool = isHandTool ?? false
        self.isMaxliner = isMaxliner ?? false
        self.isRoofRack = isRoofRack ?? false
        self.isJackCar = isJackCar ?? false
        self.isCableChargeEV = isCableChargeEV ?? false
        self.accessoriesNote = accessoriesNote ?? ""
        
    }

	mutating func mapping(map: Map) {

		spareOverAllId <- map["spareOverAllId"]
		spareNote <- map["spareNote"]
		isSpareType <- map["isSpareType"]
		isHandTool <- map["isHandTool"]
		isMaxliner <- map["isMaxliner"]
		isRoofRack <- map["isRoofRack"]
		isJackCar <- map["isJackCar"]
		isCableChargeEV <- map["isCableChargeEV"]
		accessoriesNote <- map["accessoriesNote"]
	}

}
