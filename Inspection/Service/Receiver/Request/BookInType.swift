/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct BookInType : Mappable {
    
    var bookInNumber : String?
	var bookInDate : String?
	var senderName : String?
	var receiverName : String?
	var contractNumber : String?
	var mobileNumber : String?
    var status : Int?
    var sellerCode : String?
    var inspector : String?
	var senderSignature : String? //base64
	var receiverSignature : String? //base64
    var vehicleId : String?
    var latestUpdatedDate : String?
    var bookinType: String?
    
	init?(map: Map) {
        
	}
    init(status : Int?, inspector : String?){
        self.status = status
        self.inspector = inspector
    }
    init(vehicleId : String?){
        self.vehicleId = vehicleId
    }
    init(
        bookInDate : String?,
        senderName : String?,
        receiverName : String?,
        contractNumber : String?,
        mobileNumber : String?,
        status : Int?,
        sellerCode : String?,
        inspector : String?,
        senderSignature : String?,
        receiverSignature : String?,
        latestUpdatedDate : String?,
        bookinType: String?) {
        
        self.bookInDate = bookInDate
        self.senderName = senderName
        self.receiverName = receiverName
        self.contractNumber = contractNumber
        self.mobileNumber = mobileNumber
        self.senderSignature = senderSignature
        self.receiverSignature = receiverSignature
        self.status = status
        self.sellerCode = sellerCode
        self.inspector = inspector
        self.latestUpdatedDate = latestUpdatedDate
        
        self.bookinType = bookinType
    }

	mutating func mapping(map: Map) {
        bookInNumber <- map["bookInNumber"]
        bookInDate <- map["bookInDate"]
		senderName <- map["senderName"]
        receiverName <- map["receiverName"]
		contractNumber <- map["contractNumber"]
		mobileNumber <- map["mobileNumber"]
		senderSignature <- map["senderSignature"]
        receiverSignature <- map["receiverSignature"]
		status <- map["status"]
        sellerCode <- map["sellerCode"]
        inspector <- map["inspector"]
        vehicleId <- map["vehicleId"]
        latestUpdatedDate <- map["latestUpdatedDate"]
        bookinType <- map["bookinType"]
	}

}
