//
//  InspectionImageListService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 28/4/2564 BE.
//

import Foundation
import Alamofire

class InspectionImageListService : BaseApi<BookInDetailRequest , InspectionImageListResponse> {
    override func createUrlReq(_ encRequest: BookInDetailRequest) -> URLRequestConvertible {
        return Router.listInspectionImage(encRequest.toJSON(), encRequest.bookInNumber).apiModel
    }
    override func callServiceArray(request: BookInDetailRequest, _ completionHandler: @escaping (Result<[InspectionImageListResponse], KError>) -> Void) {
        super.executeArray(request: request, completionHandler)
    }
}
