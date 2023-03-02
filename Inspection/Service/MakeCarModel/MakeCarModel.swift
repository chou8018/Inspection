//
//  MakeCarModel.swift
//  Inspection
//
//  Created by Thanawat prathumset on 10/3/2564 BE.
//

import Foundation
import ObjectMapper

struct MakeCarModel : Mappable {
//    "makeEn": "ALFA ROMEO",
//   "makeTh": "Alfa Romeo"
    var makeEn: String?
    var makeTh: String?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        makeEn <- map["makeEn"]
        makeTh <- map["makeTh"]
    }
}
