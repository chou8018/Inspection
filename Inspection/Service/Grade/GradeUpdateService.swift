//
//  GradeUpdateService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 23/4/2564 BE.
//

import Foundation
import Alamofire

class GradeUpdateService : BaseApi<GradeRequest , BaseResponse> {
    override func createUrlReq(_ encRequest: GradeRequest) -> URLRequestConvertible {
        return Router.gradeUpdate(encRequest.toJSON(), encRequest.bookInNumber ?? "").apiModel
    }
    
    override func callServiceObject(request: GradeRequest, _ completionHandler: @escaping (Result<BaseResponse, KError>) -> Void) {
        super.executeObject(request: request, completionHandler)
    }
}
