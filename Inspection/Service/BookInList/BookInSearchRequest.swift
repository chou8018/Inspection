//
//  BookInSearchRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 7/4/2564 BE.
//

import Foundation
import ObjectMapper

struct BookInSearchRequest : Mappable {
    
    var searchType : SearchBy.TYPE!
    var registration : String?
    var vin  : String?
    var engineno  : String?
    
    
    init(keyword: String, searchType: SearchBy.TYPE) {

        self.searchType = searchType
        
        switch searchType {
            case .REGISTRATION_CAR: self.registration = keyword
            case .VIN: self.vin = keyword
            case .ENGINE_NUMBER: self.engineno = keyword
        }
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        registration <- map["registration"]
        vin  <- map["vin"]
        engineno  <- map["engineno"]
        
    }
    
    
}
