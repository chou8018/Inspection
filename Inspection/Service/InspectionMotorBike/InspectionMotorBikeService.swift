//
//  InspectionMotorBikeService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 8/10/2564 BE.
//

import Foundation
import Alamofire

class InspectionMotorBikeService: BaseApi<InspectionMotorBikeModel , BaseResponse> {
    override func createUrlReq(_ encRequest: InspectionMotorBikeModel) -> URLRequestConvertible {
        return Router.createInspecMotorBike(encRequest.toJSON()).apiModel
    }
    
    override func callServiceObject(request: InspectionMotorBikeModel, _ completionHandler: @escaping (Result<BaseResponse, KError>) -> Void) {
        
        super.executeObject(request: request, completionHandler)
    }
}
