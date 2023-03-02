//
//  LoginResponse.swift
//  Inspection
//
//  Created by Thanawat prathumset on 6/5/2564 BE.
//

import Foundation
import ObjectMapper

struct LoginResponse  : Mappable {
    
    var isUser : Bool?
    var username : String?
    var password : String?
    var mail : String?
    var firstName : String?
    var lastName : String?
    var guid : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        isUser <- map["isUser"]
        username <- map["username"]
        password <- map["password"]
        mail <- map["mail"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        guid <- map["guid"]
    }

}
