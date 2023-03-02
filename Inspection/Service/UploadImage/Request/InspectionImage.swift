/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct InspectionImage : Mappable {
	var bookInNumber : String? = ""
	var vehicleId : String? = ""
	var imageTypeId : Int? = 0
	var imageDescTh : String? = ""
	var imageDescEn : String? = ""
	var imageName : String? = ""
	var imagePath : String? = ""
    var imageId : Int?
    
    var damageDesc: String? = ""
    var damageSize: String? = ""
    var damageType: String? = ""
    
	init?(map: Map) {

	}
    
    init(
    bookInNumber : String?,
    vehicleId : String?,
    imageTypeId : Int?,
    imageDescTh : String?,
    imageDescEn : String?,
    imageName : String?,
    imagePath : String?,
    damageDesc: String?,
    damageSize: String?,
    damageType: String?){
        
        self.bookInNumber = bookInNumber ?? ""
        self.vehicleId = vehicleId ?? ""
        self.imageTypeId = imageTypeId ?? 0
        self.imageDescTh = imageDescTh ?? ""
        self.imageDescEn = imageDescEn ?? ""
        self.imageName = imageName ?? ""
        self.imagePath = imagePath ?? ""
        
        self.damageDesc = damageDesc ?? ""
        self.damageSize = damageSize ?? ""
        self.damageType = damageType ?? ""
    }

	mutating func mapping(map: Map) {

		bookInNumber <- map["bookInNumber"]
		vehicleId <- map["vehicleId"]
		imageTypeId <- map["imageTypeId"]
		imageDescTh <- map["imageDescTh"]
		imageDescEn <- map["imageDescEn"]
		imageName <- map["imageName"]
		imagePath <- map["imagePath"]
        imageId <- map["imageId"]
        
        damageDesc <- map["damageDesc"]
        damageSize <- map["damageSize"]
        damageType <- map["damageType"]
	}

}
