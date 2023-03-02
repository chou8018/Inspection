//
//  ModelCarModel.swift
//  Inspection
//
//  Created by Thanawat prathumset on 10/3/2564 BE.
//

import Foundation
import ObjectMapper

struct ModelCarModel : Mappable {
//    "modelEn": "ALPHARD",
//    "modelTh": "อัลฟาร์ด"
    var modelEn: String?
    var modelTh: String?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        modelEn <- map["modelEn"]
        modelTh <- map["modelTh"]
    }
}
