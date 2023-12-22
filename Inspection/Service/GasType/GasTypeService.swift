//
//  GearBoxService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import Alamofire

class GasTypeService : BaseApi<BaseRequest , GasTypeModel> {
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getGasTypes(encRequest.toJSON()).apiModel
    }
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[GasTypeModel], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
