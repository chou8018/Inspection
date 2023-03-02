//
//  File.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 25/6/2564 BE.
//

import Foundation
import Alamofire

class JatoVaraintsService: BaseApi<JatoVaraintsModelRequest, JatoVaraintsModel> {
    override func createUrlReq(_ encRequest: JatoVaraintsModelRequest) -> URLRequestConvertible {
        return Router.getJatoVaraints(encRequest.toJSON(), encRequest.model_BU).apiModel
    }
    override func callServiceArray(request: JatoVaraintsModelRequest, _ completionHandler: @escaping (Result<[JatoVaraintsModel], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
