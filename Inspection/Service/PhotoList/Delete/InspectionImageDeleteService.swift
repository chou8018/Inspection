//
//  InspectionImageDeleteService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 28/4/2564 BE.
//

import Foundation
import Alamofire

class InspectionImageDeleteService: BaseApi<InspectionImageDeleteRequest, BaseResponse> {
    override func createUrlReq(_ encRequest: InspectionImageDeleteRequest) -> URLRequestConvertible {
        return Router.deleteInspectionImage(encRequest.toJSON()).apiModel
    }
    override func callServiceObject(request: InspectionImageDeleteRequest, _ completionHandler: @escaping (Result<BaseResponse, KError>) -> Void) {
        super.executeObject(request: request, completionHandler)
    }
}
