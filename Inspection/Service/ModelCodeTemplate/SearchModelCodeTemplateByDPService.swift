//
//  SearchModelCodeTemplateByDP.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 25/6/2564 BE.
//

import Foundation
import Alamofire

class SearchModelCodeTemplateByDPService : BaseApi<SearchModelRequest, ModelCodeTemplateModel> {
    
    
    override func createUrlReq(_ encRequest: SearchModelRequest) -> URLRequestConvertible {
        return Router.searchModelCodeTemplateByDisplay(encRequest.toJSON()).apiModel
    }
    
    override func callServiceArray(request: SearchModelRequest, _ completionHandler: @escaping (Result<[ModelCodeTemplateModel], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
