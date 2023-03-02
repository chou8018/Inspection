//
//  SearchCodeRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 10/3/2564 BE.
//

import Foundation
import ObjectMapper

struct SearchCodeRequest : Mappable {
    var year: String = ""
    var make: String = ""
    var model: String = ""
    var modelCode: String = ""
    
    init(modelCode:String) {
        self.modelCode = modelCode
    }
    
    init(year:String, make:String, model:String) {
        self.year = year
        self.make = make
        self.model = model
    }
    
    
    init?(map: Map) {
    
    }
    mutating func mapping(map: Map) {
        
    }
}
