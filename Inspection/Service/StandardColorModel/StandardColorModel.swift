//
//  StandardColorModel.swift
//  Inspection
//
//  Created by Thanawat prathumset on 15/3/2564 BE.
//

import Foundation
import ObjectMapper

struct StandardColorModel : Mappable {
    
    /*
     {
     "cid": 3,
             "colour_BU": "Black-Blue-Orange",
             "colour_LO": "ดำ-น้ำเงิน-ส้ม"
        }
 */
    var cid : Int?
    var colour_BU : String?
    var colour_LO : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        cid <- map["cid"]
        colour_BU <- map["colour_BU"]
        colour_LO <- map["colour_LO"]
    }
    
    
}
