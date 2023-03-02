//
//  ReceiverUpdateService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 29/3/2564 BE.
//

import Foundation
import Alamofire

class ReceiverUpdateService: BaseApi<ReceiverModelRequest , ReceiverModelResponse> {
    override func createUrlReq(_ encRequest: ReceiverModelRequest) -> URLRequestConvertible {
        return Router.receiversBookinUpdate(encRequest.toJSON(), encRequest.bookinNo ?? "").apiModel
    }
    
    override func callServiceObject(request: ReceiverModelRequest, _ completionHandler: @escaping (Result<ReceiverModelResponse, KError>) -> Void) {
        
        super.executeObject(request: request, completionHandler)
    }
}
