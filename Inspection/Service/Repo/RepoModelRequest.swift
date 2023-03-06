//
//  VehicleModelRequest.swift
//  Inspection
//
//  Created by Thanawat prathumset on 18/5/2564 BE.
//

import Foundation
import ObjectMapper

struct RepoModelRequest : Mappable {

    var vehicleNo: String?
    var contractNo: String?
    var dataDate: String?
    var warehouseName: String?
    var oldBuyer: String?
    var deliveryPerson: String?

    init?(map: Map) {
        
    }
    init(
        vehicleNo: String?,
        contractNo: String?,
        dataDate: String?,
        warehouseName: String?,
        oldBuyer: String?,
        deliveryPerson: String?
    ){
        
        self.vehicleNo = vehicleNo
        self.contractNo = contractNo
        self.dataDate = dataDate
        self.warehouseName = warehouseName
        self.oldBuyer = oldBuyer
        self.deliveryPerson = deliveryPerson

    }
    
    mutating func mapping(map: Map) {
        self.vehicleNo <- map["vehicleNo"]
        self.contractNo <- map["contractNo"]
        self.dataDate <- map["DataDate"]
        self.warehouseName <- map["WarehouseName"]
        self.oldBuyer <- map["OldBuyer"]
        self.deliveryPerson <- map["DeliveryPerson"]
    }

}
