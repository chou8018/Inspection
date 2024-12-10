//
//  GearBoxService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import Alamofire

class WindowOptionService : BaseApi<BaseRequest , WindowOptionModel> {
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getWindowOptions(encRequest.toJSON()).apiModel
    }
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[WindowOptionModel], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
