//
//  SellerService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 5/3/2564 BE.
//

import Foundation
import Alamofire

class DeliveryPersonService : BaseApi<BaseRequest , DeliveryPersonModel>{
    
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getDeliveryPerson(encRequest.toJSON()).apiModel
    }
    
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[DeliveryPersonModel], KError>) -> Void) {
        super.executeArray(request: request, completionHandler)
    }
}
