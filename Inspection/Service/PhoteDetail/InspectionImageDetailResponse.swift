//
//  InspectionImageListResponse.swift
//  Inspection
//
//  Created by Thanawat prathumset on 29/4/2564 BE.
//

import Foundation
import ObjectMapper

struct InspectionImageDetailResponse : Mappable {
    var base64String : String?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        base64String <- map["base64String"]
    }
    
}
