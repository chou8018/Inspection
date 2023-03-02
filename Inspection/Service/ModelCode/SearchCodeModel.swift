/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct SearchCodeModel : Mappable {
    /**
     [
         {
             "modelCode": 755817320090302,
             "modelDisplay": "2009 TOYOTA COROLLA ALTIS",
             "buildYear": "2009",
             "make_BU": "TOYOTA",
             "make_LO": "โตโยต้า",
             "model_BU": "COROLLA ALTIS",
             "model_LO": "โคโรลล่า อัลติส",
             "variants": "1.6 SS-I AUTO",
             "description_BU": "TOYOTA COROLLA ALTIS 1.6 SS-I AUTO",
             "description_LO": "โตโยต้า โคโรลล่า อัลติส 1.6 SS-I AUTO",
             "engineCapacity": 1600.0,
             "engineCapacityUnit": "cc",
             "fuelDelivery": "8501",
             "fuelType": "1",
             "fuelType_Desc": "N/A",
             "gearbox": "A",
             "gearbox_Desc": "Automatic",
             "gears": "",
             "drivenWheels": "F",
             "drivenWheels_Desc": "Front",
             "body": "SA",
             "body_Desc": "Sedan",
             "cabType": ""
         }
     ]
     */
	var modelCode : Int?
	var modelDisplay : String?
	var buildYear : String?
	var make_BU : String?
	var make_LO : String?
	var model_BU : String?
	var model_LO : String?
	var variants : String?
	var description_BU : String?
	var description_LO : String?
	var engineCapacity : Double?
	var engineCapacityUnit : String?
	var fuelDelivery : String?
	var fuelType : String?
	var fuelType_Desc : String?
	var gearbox : String?
	var gearbox_Desc : String?
	var gears : String?
	var drivenWheels : String?
	var drivenWheels_Desc : String?
	var body : String?
	var body_Desc : String?
	var cabType : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		modelCode <- map["modelCode"]
		modelDisplay <- map["modelDisplay"]
		buildYear <- map["buildYear"]
		make_BU <- map["make_BU"]
		make_LO <- map["make_LO"]
		model_BU <- map["model_BU"]
		model_LO <- map["model_LO"]
		variants <- map["variants"]
		description_BU <- map["description_BU"]
		description_LO <- map["description_LO"]
		engineCapacity <- map["engineCapacity"]
		engineCapacityUnit <- map["engineCapacityUnit"]
		fuelDelivery <- map["fuelDelivery"]
		fuelType <- map["fuelType"]
		fuelType_Desc <- map["fuelType_Desc"]
		gearbox <- map["gearbox"]
		gearbox_Desc <- map["gearbox_Desc"]
		gears <- map["gears"]
		drivenWheels <- map["drivenWheels"]
		drivenWheels_Desc <- map["drivenWheels_Desc"]
		body <- map["body"]
		body_Desc <- map["body_Desc"]
		cabType <- map["cabType"]
	}

}
