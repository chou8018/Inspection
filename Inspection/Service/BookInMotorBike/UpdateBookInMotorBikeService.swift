//
//  UpdateBookInMotorBikeService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 7/10/2564 BE.
//

import Foundation
import Alamofire

class UpdateBookInMotorBikeService: BaseApi<BookInMotorBikeModelRequest , BaseResponse> {
 
    override func createUrlReq(_ encRequest: BookInMotorBikeModelRequest) -> URLRequestConvertible {
        return Router.updateBookInMotorBike(encRequest.toJSON(), encRequest.bookinNo ?? "").apiModel
    }
    
    override func callServiceObject(request: BookInMotorBikeModelRequest, _ completionHandler: @escaping (Result<BaseResponse, KError>) -> Void) {
        
        super.executeObject(request: request, completionHandler)
    }
}
