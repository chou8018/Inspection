//
//  JatoCarModelService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 25/6/2564 BE.
//

import Foundation
import Alamofire

class JatoCarModelService: BaseApi<BaseRequest , JatoCarModelsModel>{

    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getJatoModel(encRequest.toJSON()).apiModel
    }
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[JatoCarModelsModel], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
