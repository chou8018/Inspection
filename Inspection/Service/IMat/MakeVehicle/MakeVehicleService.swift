//
//  MakeVehicleService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 18/5/2564 BE.
//

import Foundation
import Alamofire


class MakeVehicleService : BaseApi<VehicleModelRequest , MakeVehicleResponse>{
    override func createUrlReq(_ encRequest: VehicleModelRequest) -> URLRequestConvertible {
        return Router.createVehicle(encRequest.toJSON()).apiModel
    }
    override func callServiceObject(request: VehicleModelRequest, _ completionHandler: @escaping (Result<MakeVehicleResponse, KError>) -> Void) {
        
        super.executeObject(request: request, completionHandler)
    }
}
