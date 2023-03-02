//
//  InspectionImageRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 28/4/2564 BE.
//

import Foundation
import ObjectMapper

class InspectionImageRequest : Mappable {
    var inspectionImage : InspectionImage?
    var base64String : String? = ""
    
    required init?(map: Map) {
        
    }
    
    init(inspectionImage : InspectionImage?, base64String : String?){
        self.inspectionImage = inspectionImage
        self.base64String = base64String ?? ""
    }
    
    func mapping(map: Map) {
        inspectionImage <- map["inspectionImage"]
        base64String <- map["base64String"]
    }
    
    
}
