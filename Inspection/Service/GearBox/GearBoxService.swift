//
//  GearBoxService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import Alamofire

class GearBoxService : BaseApi<BaseRequest , GearBoxModel> {
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getGearBox(encRequest.toJSON()).apiModel
    }
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[GearBoxModel], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
