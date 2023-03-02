//
//  BookInDetailService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 1/4/2564 BE.
//

import Foundation
import Alamofire
//class BookInDetailService : BaseApi<BookInDetailRequest , ReceiverModelRequest> {
class BookInDetailService : BaseApi<BookInDetailRequest , BookInMotorBikeModelRequest> {
    
    override func createUrlReq(_ encRequest: BookInDetailRequest) -> URLRequestConvertible {
        return Router.bookInDetail(encRequest.toJSON(), encRequest.bookInNumber).apiModel
    }
    
    override func callServiceObject(request: BookInDetailRequest, _ completionHandler: @escaping (Result<BookInMotorBikeModelRequest, KError>) -> Void) {
        
        super.executeObject(request: request, completionHandler)
    }
}
