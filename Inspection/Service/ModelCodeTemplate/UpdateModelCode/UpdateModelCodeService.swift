//
//  UpdateModelCodeService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 30/6/2564 BE.
//

import Foundation
import Alamofire

class UpdateModelCodeService : BaseApi<CreateModelCodeRequest , BaseResponse> {
    override func createUrlReq(_ encRequest: CreateModelCodeRequest) -> URLRequestConvertible {
        return Router.updateModelCode(encRequest.toJSON()).apiModel
    }
    
    override func callServiceObject(request: CreateModelCodeRequest, _ completionHandler: @escaping (Result<BaseResponse, KError>) -> Void) {
        
        super.executeObject(request: request, completionHandler)
    }
}
