//
//  CreateModelCodeService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import Alamofire

class CreateModelCodeService : BaseApi<CreateModelCodeRequest , BaseResponse> {
    override func createUrlReq(_ encRequest: CreateModelCodeRequest) -> URLRequestConvertible {
        return Router.createModelCode(encRequest.toJSON()).apiModel
    }
    override func callServiceObject(request: CreateModelCodeRequest, _ completionHandler: @escaping (Result<BaseResponse, KError>) -> Void) {
    
        super.executeObject(request: request, completionHandler)
    }
}
