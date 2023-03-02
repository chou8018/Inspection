//
//  BodyTypeService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 16/3/2564 BE.
//

import Foundation

import Alamofire

class BodyTypeService : BaseApi<BaseRequest , BodyTypeModel> {
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getBodyType(encRequest.toJSON()).apiModel
    }
    
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[BodyTypeModel], KError>) -> Void) {
        super.executeArray(request: request, completionHandler)
    }
}

