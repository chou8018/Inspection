//
//  BookInMotorBikeService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 7/10/2564 BE.
//

import Foundation
import Alamofire

class BookInMotorBikeService: BaseApi<BookInMotorBikeModelRequest, ReceiverModelResponse> {
    override func createUrlReq(_ encRequest: BookInMotorBikeModelRequest) -> URLRequestConvertible {
     
        return Router.bookInMotorBike(encRequest.toJSON()).apiModel
    }
    
    override func callServiceObject(request: BookInMotorBikeModelRequest, _ completionHandler: @escaping (Result<ReceiverModelResponse, KError>) -> Void) {
        
        super.executeObject(request: request, completionHandler)
    }
}
