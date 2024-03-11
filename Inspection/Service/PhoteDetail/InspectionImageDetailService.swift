//
//  InspectionImageListService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 28/4/2564 BE.
//

import Foundation
import Alamofire

class InspectionImageDetailService : BaseApi<InspectionImageDetailRequest , InspectionImageDetailResponse> {
    
    override func createUrlReq(_ encRequest: InspectionImageDetailRequest) -> URLRequestConvertible {
        return Router.inspectionDetailImage(encRequest.imageId, encRequest.bookInNumber).apiModel
    }
    override func callServiceObject(request: InspectionImageDetailRequest, _ completionHandler: @escaping (Result<InspectionImageDetailResponse, KError>) -> Void) {
        super.executeObject(request: request, completionHandler)
    }
}
