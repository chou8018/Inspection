//
//  FuelDeliveryService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import Alamofire

class FuelDeliveryService : BaseApi<BaseRequest , FuelDeliveryModel> {
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getFueldelivery(encRequest.toJSON()).apiModel
    }
    
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[FuelDeliveryModel], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
