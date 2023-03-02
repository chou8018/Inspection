//
//  FuelTypeService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import Alamofire

class FuelTypeService : BaseApi<BaseRequest , FuelTypeModel> {
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getFueltype(encRequest.toJSON()).apiModel
    }
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[FuelTypeModel], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
