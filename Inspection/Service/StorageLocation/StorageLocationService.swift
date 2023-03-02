//
//  StorageLocationService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 16/3/2564 BE.
//

import Foundation
import Alamofire

class StorageLocationService: BaseApi<BaseRequest , StorageLocationModel> {
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getStandardStorage(encRequest.toJSON()).apiModel
    }
    
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[StorageLocationModel], KError>) -> Void) {
        super.executeArray(request: request, completionHandler)
    }
}
