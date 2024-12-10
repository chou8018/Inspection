//
//  GearBoxService.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 24/6/2564 BE.
//

import Foundation
import Alamofire

class RoofTypeService : BaseApi<BaseRequest , RoofTypeModel> {
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getRoofTypes(encRequest.toJSON()).apiModel
    }
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[RoofTypeModel], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
