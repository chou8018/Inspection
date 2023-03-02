//
//  InspectionImageDeleteRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 28/4/2564 BE.
//

import Foundation
import ObjectMapper

struct InspectionImageDeleteRequest : Mappable {
 
    var vehicleId : String? = ""
    var bookInNumber : String? = ""
    var imageName : String? = ""
    var imageTypeId: Int? = 0
    
    init?(map: Map) {
        
    }
    init(bookInNumber : String? , imageName : String?, vehicleId : String?, imageTypeId : Int?) {
        self.bookInNumber = bookInNumber
        self.imageName = imageName
        self.vehicleId = vehicleId
        self.imageTypeId = imageTypeId
    }
    
    mutating func mapping(map: Map) {
        bookInNumber <- map["bookInNumber"]
        imageName <- map["imageName"]
        vehicleId <- map["vehicleId"]
        imageTypeId <- map["imageTypeId"]
    }
    
     
}
