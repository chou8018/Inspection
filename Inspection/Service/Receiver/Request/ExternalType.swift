/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ExternalType : Mappable {
	var gradeOverallId : Int?
	var colorOverallId : Int?
	var isSpoiler : Bool = false
	var magWheel : Int = 0
	var normalWheel : Int = 0
	var isTyre : Bool = false
    var tyreBrand : String = ""
	var tyreQuality : Int = 0
	var damageDesc : String = ""


	init?(map: Map) {

	}

    init(
        gradeOverallId : Int?,
        colorOverallId : Int?,
        isSpoiler : Bool?,
        magWheel : Int?,
        normalWheel : Int?,
        isTyre : Bool?,
        tyreBrand : String?,
        tyreQuality : Int?,
        damageDesc : String?){
    
        self.gradeOverallId  = gradeOverallId
        self.colorOverallId = colorOverallId
        self.isSpoiler = isSpoiler ?? false
        self.magWheel = magWheel ?? 0
        self.normalWheel = normalWheel ?? 0
        self.isTyre = isTyre ?? false
        self.tyreBrand = tyreBrand ?? ""
        self.tyreQuality = tyreQuality ?? 0
        self.damageDesc = damageDesc ?? ""
    
    }
    
	mutating func mapping(map: Map) {

		gradeOverallId <- map["gradeOverallId"]
		colorOverallId <- map["colorOverallId"]
		isSpoiler <- map["isSpoiler"]
		magWheel <- map["magWheel"]
		normalWheel <- map["normalWheel"]
		isTyre <- map["isTyre"]
        tyreBrand <- map["tyreBrand"]
		tyreQuality <- map["tyreQuality"]
		damageDesc <- map["damageDesc"]

	}

}
