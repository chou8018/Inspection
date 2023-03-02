//
//  ModelCarRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 10/3/2564 BE.
//

import Foundation
import ObjectMapper

struct ModelCarRequest : Mappable {
    
    var make: String = ""
    
    init(make:String) {
        self.make = make
    }
    
    
    init?(map: Map) {
    
    }
    mutating func mapping(map: Map) {
        
    }
    
 
}
