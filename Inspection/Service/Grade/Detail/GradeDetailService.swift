//
//  GradeDetailService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 23/4/2564 BE.
//

import Foundation
import Alamofire

class GradeDetailService : BaseApi<BookInDetailRequest , GradeResponse> {
    override func createUrlReq(_ encRequest: BookInDetailRequest) -> URLRequestConvertible {
        return Router.gradeDetail(encRequest.toJSON(), encRequest.bookInNumber).apiModel
    }
    
    override func callServiceObject(request: BookInDetailRequest, _ completionHandler: @escaping (Result<GradeResponse, KError>) -> Void) {
        super.executeObject(request: request, completionHandler)
    }
}
