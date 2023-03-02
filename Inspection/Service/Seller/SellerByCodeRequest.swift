//
//  SellerByCodeRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 1/4/2564 BE.
//

import Foundation
import ObjectMapper

struct SellerByCodeRequest :  Mappable {
    
    var sellerCode:String?
    
    init(sellerCode : String?){
        self.sellerCode = sellerCode
    }
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        
    }
    
    
}
