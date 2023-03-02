//
//  SellCateService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 22/6/2564 BE.
//

import Foundation
import Alamofire

class SellCateService: BaseApi<BaseRequest , SellCateResponse> {
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.sellcategory(encRequest.toJSON()).apiModel
    }
    
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[SellCateResponse], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
