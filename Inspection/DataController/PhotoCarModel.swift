//
//  PhotoCar.swift
//  Inspection
//
//  Created by Thanawat prathumset on 3/3/2564 BE.
//

import Foundation

class PhotoCarModel {
    var indexSection: Int = 0 
    var sectionName: String = "Front_B"
    var itemList : PhotoCarResponse = [:]
    var hasSection:[(String,Int)] = []
    var hasCheckSection:[String:Bool] = [:]
    var damageItemLists : [InspectionImageListResponse] = []
}
