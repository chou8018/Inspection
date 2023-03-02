//
//  DriveService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import Alamofire

class DriveService : BaseApi<BaseRequest , DriveModel> {
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getDrive(encRequest.toJSON()).apiModel
    }
    
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[DriveModel], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
