//
//  SearchModelCodeTempleteByCHService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import Alamofire

class SearchModelCodeTempleteByCHService: BaseApi<SearchModelRequest , ModelCodeTemplateModel> {
    override func createUrlReq(_ encRequest: SearchModelRequest) -> URLRequestConvertible {
        return Router.searchModelCodeTemplateByChassis(encRequest.toJSON()).apiModel
    }
    
    override func callServiceArray(request: SearchModelRequest, _ completionHandler: @escaping (Result<[ModelCodeTemplateModel], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
