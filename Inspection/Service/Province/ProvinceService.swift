//
//  ProvinceService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 15/3/2564 BE.
//

import Foundation
import  Alamofire

class ProvinceService : BaseApi<BaseRequest, ProvinceModel> {
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.getStandardProvinceList(encRequest.toJSON()).apiModel
    }
    
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[ProvinceModel], KError>) -> Void) {
        super.executeArray(request: request, completionHandler)
    }
}
