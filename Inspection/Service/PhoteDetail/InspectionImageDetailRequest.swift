//
//  InspectionImageDetailRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 28/4/2564 BE.
//

import Foundation
import ObjectMapper

struct InspectionImageDetailRequest : Mappable {
 
    
    var bookInNumber : String = ""
    var imageId: Int = 0

    var imageName : String? = ""
    var vehicleId : String? = ""

    init?(map: Map) {
        
    }
    init(bookInNumber : String ,imageId : Int , imageName : String? = "", vehicleId : String? = "") {
        self.bookInNumber = bookInNumber
        self.imageId = imageId
        self.imageName = imageName
        self.vehicleId = vehicleId
    }
    
    mutating func mapping(map: Map) {
        bookInNumber <- map["bookInNumber"]
        imageName <- map["imageName"]
        vehicleId <- map["vehicleId"]
        imageId <- map["imageTypeId"]
    }
    
     
}
