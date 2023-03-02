//
//  InspectionDetailService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 21/4/2564 BE.
//

import Foundation
import Alamofire

class InspectionDetailService : BaseApi<BookInDetailRequest , InspectionDetailResponse> {
    override func createUrlReq(_ encRequest: BookInDetailRequest) -> URLRequestConvertible {
        return Router.inspectionDetail(encRequest.toJSON(), encRequest.bookInNumber).apiModel
    }
    override func callServiceObject(request: BookInDetailRequest, _ completionHandler: @escaping (Result<InspectionDetailResponse, KError>) -> Void) {
        super.executeObject(request: request, completionHandler)
    }
}
