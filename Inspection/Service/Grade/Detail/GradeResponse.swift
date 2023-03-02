/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct GradeResponse : Mappable {
	var gradeId : Int?
	var vehicleId : String?
	var gradeSummary : String?
	var isExcellence1 : Bool?
	var isExcellence2 : Bool?
	var isExcellence3 : Bool?
	var isExcellence4 : Bool?
	var isExcellence5 : Bool?
	var isGood1 : Bool?
	var isGood2 : Bool?
	var isGood3 : Bool?
	var isGood4 : Bool?
	var isAverage1 : Bool?
	var isAverage2 : Bool?
	var isAverage3 : Bool?
	var isAverage4 : Bool?
	var isFair1 : Bool?
	var isFair2 : Bool?
	var isFair3 : Bool?
	var isFair4 : Bool?
	var isFair5 : Bool?
	var isFair6 : Bool?
	var isFair7 : Bool?
	var isFair8 : Bool?
	var isFair9 : Bool?
	var isFair10 : Bool?
	var isFair11 : Bool?
	var isPoor1 : Bool?
	var isPoor2 : Bool?
	var isPoor3 : Bool?
	var isPoor4 : Bool?
	var isPoor5 : Bool?
	var isPoor6 : Bool?
	var isPoor7 : Bool?
	var isPoor8 : Bool?
	var isPoor9 : Bool?
	var isX : Bool?
	var isY : Bool?
	var bookInNumber : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		gradeId <- map["gradeId"]
		vehicleId <- map["vehicleId"]
		gradeSummary <- map["gradeSummary"]
		isExcellence1 <- map["isExcellence1"]
		isExcellence2 <- map["isExcellence2"]
		isExcellence3 <- map["isExcellence3"]
		isExcellence4 <- map["isExcellence4"]
		isExcellence5 <- map["isExcellence5"]
		isGood1 <- map["isGood1"]
		isGood2 <- map["isGood2"]
		isGood3 <- map["isGood3"]
		isGood4 <- map["isGood4"]
		isAverage1 <- map["isAverage1"]
		isAverage2 <- map["isAverage2"]
		isAverage3 <- map["isAverage3"]
		isAverage4 <- map["isAverage4"]
		isFair1 <- map["isFair1"]
		isFair2 <- map["isFair2"]
		isFair3 <- map["isFair3"]
		isFair4 <- map["isFair4"]
		isFair5 <- map["isFair5"]
		isFair6 <- map["isFair6"]
		isFair7 <- map["isFair7"]
		isFair8 <- map["isFair8"]
		isFair9 <- map["isFair9"]
		isFair10 <- map["isFair10"]
		isFair11 <- map["isFair11"]
		isPoor1 <- map["isPoor1"]
		isPoor2 <- map["isPoor2"]
		isPoor3 <- map["isPoor3"]
		isPoor4 <- map["isPoor4"]
		isPoor5 <- map["isPoor5"]
		isPoor6 <- map["isPoor6"]
		isPoor7 <- map["isPoor7"]
		isPoor8 <- map["isPoor8"]
		isPoor9 <- map["isPoor9"]
		isX <- map["isX"]
		isY <- map["isY"]
		bookInNumber <- map["bookInNumber"]
	}

}
