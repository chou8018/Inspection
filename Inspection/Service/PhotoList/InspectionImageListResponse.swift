//
//  InspectionImageListResponse.swift
//  Inspection
//
//  Created by Thanawat prathumset on 29/4/2564 BE.
//

import Foundation
import ObjectMapper

struct InspectionImageListResponse : Mappable {
    var imageName : String?
    var imageData : String?
    var damageDesc: String?
    var damageSize: String?
    var damageType: String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        imageName <- map["imageName"]
        imageData <- map["imageData"]
        damageDesc <- map["damageDesc"]
        damageSize <- map["damageSize"]
        damageType <- map["damageType"]
    }

    
}
