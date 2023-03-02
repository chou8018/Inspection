//
//  ReceiverModelResponse.swift
//  Inspection
//
//  Created by Thanawat prathumset on 25/3/2564 BE.
//

import Foundation
import ObjectMapper

struct ReceiverModelResponse : Mappable {
    
    var bookinNo: String?
    init?(map: Map) {
    }
    
    init(bookinNo:String) {
        self.bookinNo = bookinNo
    }
    
    mutating func mapping(map: Map) {
        bookinNo <- map["bookinNo"]
    }
    
    
    
}
