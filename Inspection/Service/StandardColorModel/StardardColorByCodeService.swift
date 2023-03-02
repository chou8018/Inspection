//
//  StardardColorByCodeService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 2/4/2564 BE.
//

import Foundation
import Alamofire

class StardardColorByCodeService: BaseApi<StandardColorRequest, StandardColorModel> {
    override func createUrlReq(_ encRequest: StandardColorRequest) -> URLRequestConvertible {
        return Router.getStandardColorByCode(encRequest.toJSON(), encRequest.cid ?? "").apiModel
    }
    
    override func callServiceObject(request: StandardColorRequest, _ completionHandler: @escaping (Result<StandardColorModel, KError>) -> Void) {
        
        super.executeObject(request: request, completionHandler)
    }
}
