//
//  GradeService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 22/4/2564 BE.
//

import Foundation
import Alamofire

class GradeCreateService : BaseApi<GradeRequest , BaseResponse>{
    override func createUrlReq(_ encRequest: GradeRequest) -> URLRequestConvertible {
        return Router.grade(encRequest.toJSON()).apiModel
    }
    
    override func callServiceObject(request: GradeRequest, _ completionHandler: @escaping (Result<BaseResponse, KError>) -> Void) {
        super.executeObject(request: request, completionHandler)
    }
}
