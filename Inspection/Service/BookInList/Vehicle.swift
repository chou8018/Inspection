/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Vehicle : Mappable {
	var registration : String?
	var vin : String?
	var engineNumber : String?
	var buildYear : String?
	var make_BU : String?
	var model_BU : String?
	var variants : String?

	init?(map: Map) {

	}

    init(registration : String?,
         vin : String?,
         engineNumber : String?,
         buildYear : String?,
         make_BU : String?,
         model_BU : String?,
         variants : String?) {
        
        self.registration = registration
        self.vin = vin
        self.engineNumber = engineNumber
        self.buildYear = buildYear
        self.make_BU = make_BU
        self.model_BU = model_BU
        self.variants = variants
    }
	mutating func mapping(map: Map) {
		registration <- map["registration"]
		vin <- map["vin"]
		engineNumber <- map["engineNumber"]
		buildYear <- map["buildYear"]
		make_BU <- map["make_BU"]
		model_BU <- map["model_BU"]
		variants <- map["variants"]
	}

}
