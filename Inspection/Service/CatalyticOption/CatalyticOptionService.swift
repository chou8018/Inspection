//
//  GearBoxService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import Alamofire

class CatalyticOptionService : BaseApi<BaseRequest , CatalyticOptionModel> {
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getCatalyticOptions(encRequest.toJSON()).apiModel
    }
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[CatalyticOptionModel], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
