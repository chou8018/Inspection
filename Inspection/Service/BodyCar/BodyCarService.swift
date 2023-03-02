//
//  BodyCarService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 15/3/2564 BE.
//

import Foundation
import Alamofire

class BodyCarService : BaseApi<BaseRequest , BodyCarModel> {
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getStandardBodyList(encRequest.toJSON()).apiModel
    }
    
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[BodyCarModel], KError>) -> Void) {
        super.executeArray(request: request, completionHandler)
    }
}
