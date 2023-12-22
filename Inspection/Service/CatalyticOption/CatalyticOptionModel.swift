//
//  GearBoxModel.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import ObjectMapper

struct CatalyticOptionModel : Mappable {

    var catalyticOptionId: Int?
    var desc_BU: String?
    var desc_LO: String?

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.catalyticOptionId <- map["catalyticOptionId"]
        self.desc_BU <- map["descEn"]
        self.desc_LO <- map["descTh"]
    }
}
