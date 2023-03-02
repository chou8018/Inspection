//
//  SellerService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 5/3/2564 BE.
//

import Foundation
import Alamofire

class SellerService : BaseApi<BaseRequest , SellerModel>{
    
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getSeller(encRequest.toJSON()).apiModel
    }
    
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[SellerModel], KError>) -> Void) {
        super.executeArray(request: request, completionHandler)
    }
}
