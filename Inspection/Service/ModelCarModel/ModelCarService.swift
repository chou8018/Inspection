//
//  ModelCarService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 10/3/2564 BE.
//

import Foundation
import Alamofire

class ModelCarService : BaseApi<ModelCarRequest , ModelCarModel> {
    override func createUrlReq(_ encRequest: ModelCarRequest) -> URLRequestConvertible {
        return Router.getModel(encRequest.toJSON(), encRequest.make).apiModel
    }

    override func callServiceArray(request: ModelCarRequest, _ completionHandler: @escaping (Result<[ModelCarModel], KError>) -> Void) {
        super.executeArray(request: request, completionHandler)
    }
}
