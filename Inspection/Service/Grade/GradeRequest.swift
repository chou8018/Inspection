//
//  GradeRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 23/4/2564 BE.
//

import Foundation
import ObjectMapper

struct GradeRequest : Mappable {

    var vehicleId : String? = ""
    var gradeSummary : String? = ""
    var isExcellence1 : Bool? = false
    var isExcellence2 : Bool? = false
    var isExcellence3 : Bool? = false
    var isExcellence4 : Bool? = false
    var isExcellence5 : Bool? = false
    var isGood1 : Bool? = false
    var isGood2 : Bool? = false
    var isGood3 : Bool? = false
    var isGood4 : Bool? = false
    var isAverage1 : Bool? = false
    var isAverage2 : Bool? = false
    var isAverage3 : Bool? = false
    var isAverage4 : Bool? = false
    var isFair1 : Bool? = false
    var isFair2 : Bool? = false
    var isFair3 : Bool? = false
    var isFair4 : Bool? = false
    var isFair5 : Bool? = false
    var isFair6 : Bool? = false
    var isFair7 : Bool? = false
    var isFair8 : Bool? = false
    var isFair9 : Bool? = false
    var isFair10 : Bool? = false
    var isFair11 : Bool? = false
    var isPoor1 : Bool? = false
    var isPoor2 : Bool? = false
    var isPoor3 : Bool? = false
    var isPoor4 : Bool? = false
    var isPoor5 : Bool? = false
    var isPoor6 : Bool? = false
    var isPoor7 : Bool? = false
    var isPoor8 : Bool? = false
    var isPoor9 : Bool? = false
    var isX : Bool? = false
    var isY : Bool? = false
    var bookInNumber : String? = ""
    
    init?(map: Map) {
        
    }
    
    init(
        vehicleId : String?,
        gradeSummary : String?,
        isExcellence1 : Bool?,
        isExcellence2 : Bool?,
        isExcellence3 : Bool?,
        isExcellence4 : Bool?,
        isExcellence5 : Bool?,
        isGood1 : Bool?,
        isGood2 : Bool?,
        isGood3 : Bool?,
        isGood4 : Bool?,
        isAverage1 : Bool?,
        isAverage2 : Bool?,
        isAverage3 : Bool?,
        isAverage4 : Bool?,
        isFair1 : Bool?,
        isFair2 : Bool?,
        isFair3 : Bool?,
        isFair4 : Bool?,
        isFair5 : Bool?,
        isFair6 : Bool?,
        isFair7 : Bool?,
        isFair8 : Bool?,
        isFair9 : Bool?,
        isFair10 : Bool?,
        isFair11 : Bool?,
        isPoor1 : Bool?,
        isPoor2 : Bool?,
        isPoor3 : Bool?,
        isPoor4 : Bool?,
        isPoor5 : Bool?,
        isPoor6 : Bool?,
        isPoor7 : Bool?,
        isPoor8 : Bool?,
        isPoor9 : Bool?,
        isX : Bool?,
        isY : Bool?,
        bookInNumber : String?) {
        
        
        self.vehicleId = vehicleId ?? ""
        self.gradeSummary = gradeSummary ?? ""
        self.isExcellence1 = isExcellence1 ?? false
        self.isExcellence2 = isExcellence2 ?? false
        self.isExcellence3 = isExcellence3 ?? false
        self.isExcellence4 = isExcellence4 ?? false
        self.isExcellence5 = isExcellence5 ?? false
        self.isGood1 = isGood1 ?? false
        self.isGood2 = isGood2 ?? false
        self.isGood3 = isGood3 ?? false
        self.isGood4 = isGood4 ?? false
        self.isAverage1 = isAverage1 ?? false
        self.isAverage2 = isAverage2 ?? false
        self.isAverage3 = isAverage3 ?? false
        self.isAverage4 = isAverage4 ?? false
        self.isFair1 = isFair1 ?? false
        self.isFair2 = isFair2 ?? false
        self.isFair3 = isFair3 ?? false
        self.isFair4 = isFair4 ?? false
        self.isFair5 = isFair5 ?? false
        self.isFair6 = isFair6 ?? false
        self.isFair7 = isFair7 ?? false
        self.isFair8 = isFair8 ?? false
        self.isFair9 = isFair9 ?? false
        self.isFair10 = isFair10 ?? false
        self.isFair11 = isFair11 ?? false
        self.isPoor1 = isPoor1 ?? false
        self.isPoor2 = isPoor2 ?? false
        self.isPoor3 = isPoor3 ?? false
        self.isPoor4 = isPoor4 ?? false
        self.isPoor5 = isPoor5 ?? false
        self.isPoor6 = isPoor6 ?? false
        self.isPoor7 = isPoor7 ?? false
        self.isPoor8 = isPoor8 ?? false
        self.isPoor9 = isPoor9 ?? false
        self.isX = isX ?? false
        self.isY = isY ?? false
        self.bookInNumber = bookInNumber ?? ""
    }
    
    mutating func mapping(map: Map) {

        vehicleId <- map["vehicleId"]
        gradeSummary <- map["gradeSummary"]
        isExcellence1 <- map["isExcellence1"]
        isExcellence2 <- map["isExcellence2"]
        isExcellence3 <- map["isExcellence3"]
        isExcellence4 <- map["isExcellence4"]
        isExcellence5 <- map["isExcellence5"]
        isGood1 <- map["isGood1"]
        isGood2 <- map["isGood2"]
        isGood3 <- map["isGood3"]
        isGood4 <- map["isGood4"]
        isAverage1 <- map["isAverage1"]
        isAverage2 <- map["isAverage2"]
        isAverage3 <- map["isAverage3"]
        isAverage4 <- map["isAverage4"]
        isFair1 <- map["isFair1"]
        isFair2 <- map["isFair2"]
        isFair3 <- map["isFair3"]
        isFair4 <- map["isFair4"]
        isFair5 <- map["isFair5"]
        isFair6 <- map["isFair6"]
        isFair7 <- map["isFair7"]
        isFair8 <- map["isFair8"]
        isFair9 <- map["isFair9"]
        isFair10 <- map["isFair10"]
        isFair11 <- map["isFair11"]
        isPoor1 <- map["isPoor1"]
        isPoor2 <- map["isPoor2"]
        isPoor3 <- map["isPoor3"]
        isPoor4 <- map["isPoor4"]
        isPoor5 <- map["isPoor5"]
        isPoor6 <- map["isPoor6"]
        isPoor7 <- map["isPoor7"]
        isPoor8 <- map["isPoor8"]
        isPoor9 <- map["isPoor9"]
        isX <- map["isX"]
        isY <- map["isY"]
        bookInNumber <- map["bookInNumber"]
    }
    
    
}
