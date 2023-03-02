//
//  UpdateVehicleService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 2/6/2564 BE.
//

import Foundation
import Alamofire

class UpdateVehicleService: BaseApi<VehicleModelRequest , MakeVehicleResponse> {
    
    override func createUrlReq(_ encRequest: VehicleModelRequest) -> URLRequestConvertible {
        return Router.updateVehicle(encRequest.toJSON()).apiModel
    }
    
    override func callServiceObject(request: VehicleModelRequest, _ completionHandler: @escaping (Result<MakeVehicleResponse, KError>) -> Void) {
        
        super.executeObject(request: request, completionHandler)
    }
}
