//
//  MakeCarService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 10/3/2564 BE.
//

import Foundation
import Alamofire

class MakeCarService : BaseApi<BaseRequest , MakeCarModel> {
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getMake(encRequest.toJSON()).apiModel
    }
    
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[MakeCarModel], KError>) -> Void) {
        super.executeArray(request: request, completionHandler)
    }
}
