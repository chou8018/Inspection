//
//  InspectionUpdateService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 21/4/2564 BE.
//

import Foundation
import Alamofire

class  InspectionUpdateService: BaseApi<InspectionRequest , BaseResponse> {
    override func createUrlReq(_ encRequest: InspectionRequest) -> URLRequestConvertible {
        return Router.inspectionUpdate(encRequest.toJSON(), encRequest.bookInNumber!).apiModel
    }
    override func callServiceObject(request: InspectionRequest, _ completionHandler: @escaping (Result<BaseResponse, KError>) -> Void) {
        super.executeObject(request: request, completionHandler)
    }
}
