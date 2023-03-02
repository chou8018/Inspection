//
//  SellerByCodeService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 1/4/2564 BE.
//

import Foundation
import Alamofire

class SellerByCodeService : BaseApi<SellerByCodeRequest, SellerModel> {
    override func createUrlReq(_ encRequest: SellerByCodeRequest) -> URLRequestConvertible {
        return  Router.getSellerByCode(encRequest.toJSON(), encRequest.sellerCode ?? "" ).apiModel
    }
    
    override func callServiceArray(request: SellerByCodeRequest, _ completionHandler: @escaping (Result<[SellerModel], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
