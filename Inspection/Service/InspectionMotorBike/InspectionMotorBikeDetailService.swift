//
//  InspectionMotorBikeDetailService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 8/10/2564 BE.
//

import Foundation
import Alamofire

class InspectionMotorBikeDetailService : BaseApi<BookInDetailRequest, InspectionMotorBikeModel> {
    override func createUrlReq(_ encRequest: BookInDetailRequest) -> URLRequestConvertible {
        return Router.getInspecMotorBike(encRequest.bookInNumber).apiModel
    }
    
    override func callServiceObject(request: BookInDetailRequest, _ completionHandler: @escaping (Result<InspectionMotorBikeModel, KError>) -> Void) {
        
        super.executeObject(request: request, completionHandler)
    }
}
