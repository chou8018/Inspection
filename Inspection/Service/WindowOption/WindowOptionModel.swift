//
//  GearBoxModel.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import ObjectMapper

struct WindowOptionModel : Mappable {

    var windowOptionId: Int?
    var desc_BU: String?
    var desc_LO: String?

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.windowOptionId <- map["windowOptionId"]
        self.desc_BU <- map["descEn"]
        self.desc_LO <- map["descTh"]
    }
}
