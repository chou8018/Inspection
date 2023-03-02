//
//  BookInDetailRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 1/4/2564 BE.
//

import Foundation
import ObjectMapper

struct BookInDetailRequest : Mappable {
    
    var bookInNumber : String = ""
    
    init(bookInNumber : String?){
        self.bookInNumber = bookInNumber ?? ""
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
    
    }
    

}
