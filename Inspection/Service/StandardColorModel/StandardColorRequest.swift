//
//  StandardColorRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 2/4/2564 BE.
//

import Foundation
import ObjectMapper

struct StandardColorRequest : Mappable {
    
    var cid : String?
    
    init(cid : String?){
        self.cid = cid
    }
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
    }
    
    
}
