//
//  SearchCodeService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 10/3/2564 BE.
//

import Foundation
import Alamofire

class SearchCodeService : BaseApi<SearchCodeRequest , SearchCodeModel>{
    
    override func createUrlReq(_ encRequest: SearchCodeRequest) -> URLRequestConvertible {
        return Router.searchModelCode(encRequest.toJSON(), encRequest.year, encRequest.make, encRequest.model).apiModel
    }
    
    override func callServiceArray(request: SearchCodeRequest, _ completionHandler: @escaping (Result<[SearchCodeModel], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}


