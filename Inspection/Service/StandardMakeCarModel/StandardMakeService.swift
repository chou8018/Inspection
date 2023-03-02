//
//  StandardMakeService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 15/3/2564 BE.
//

import Foundation
import Alamofire

class StandardMakeService: BaseApi<BaseRequest , StandradMakeModel> {
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getStandardMakeList(encRequest.toJSON()).apiModel
    }
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[StandradMakeModel], KError>) -> Void) {
        super.executeArray(request: request, completionHandler)
    }
}
