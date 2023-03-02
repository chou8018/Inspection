//
//  KeyOptionType.swift
//  Inspection
//
//  Created by Thanawat prathumset on 7/4/2564 BE.
//

import Foundation
import ObjectMapper

struct KeyOptionType : Mappable {
 
    /**
     "keyOptionType": {
         "$id": "7",
         "keyOptionId": 1,
         "numberOfKey": 1,
         "numberOfRemote": 1,
         "numberOfKeyRemote": 1,
         "numberOfImmobilizer": 1,
         "numberOfKeyless": 1,
         "bookinNumber": "sample string 2"
       },
     */
    var keyOptionId : Int?
    var numberOfKey : Int = 0
    var numberOfRemote : Int = 0
    var numberOfKeyRemote : Int = 0
    var numberOfImmobilizer : Int = 0
    var numberOfKeyless : Int = 0
    var bookinNumber : String?
    
    init(numberOfKey : Int?,
        numberOfRemote : Int?,
        numberOfKeyRemote : Int?,
        numberOfImmobilizer : Int?,
        numberOfKeyless : Int?){
        
        self.numberOfKey = numberOfKey ?? 0
        self.numberOfRemote = numberOfRemote ?? 0
        self.numberOfKeyRemote = numberOfKeyRemote ?? 0
        self.numberOfImmobilizer = numberOfImmobilizer ?? 0
        self.numberOfKeyless = numberOfKeyless ?? 0
        
    }
    
    
    init?(map: Map) {
            
    }
    
    mutating func mapping(map: Map) {
        keyOptionId <- map["keyOptionId"]
        numberOfKey <- map["numberOfKey"]
        numberOfRemote <- map["numberOfRemote"]
        numberOfKeyRemote <- map["numberOfKeyRemote"]
        numberOfImmobilizer <- map["numberOfImmobilizer"]
        numberOfKeyless <- map["numberOfKeyless"]
        bookinNumber <- map["bookinNumber"]
    }
}
