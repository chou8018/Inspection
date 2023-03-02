//
//  ReceiverService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 25/3/2564 BE.
//

import Foundation
import Alamofire

class ReceiverService: BaseApi<ReceiverModelRequest , ReceiverModelResponse> {
    override func createUrlReq(_ encRequest: ReceiverModelRequest) -> URLRequestConvertible {
        return Router.receiversBookin(encRequest.toJSON()).apiModel
    }
    
    override func callServiceObject(request: ReceiverModelRequest, _ completionHandler: @escaping (Result<ReceiverModelResponse, KError>) -> Void) {
        
        super.executeObject(request: request, completionHandler)
    }
}
