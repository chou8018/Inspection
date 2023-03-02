//
//  StandardColorService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 15/3/2564 BE.
//

import Foundation
import Alamofire

class StandardColorService: BaseApi<BaseRequest , StandardColorModel> {
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getStandardColorList(encRequest.toJSON()).apiModel
    }
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[StandardColorModel], KError>) -> Void) {
        super.executeArray(request: request, completionHandler)
    }
}
