//
//  PlantService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 9/6/2564 BE.
//

import Foundation
import Alamofire

class PlantService : BaseApi<BaseRequest , PlantResponse> {
    
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.plantLocation(encRequest.toJSON()).apiModel
    }
    
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[PlantResponse], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
