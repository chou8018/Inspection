//
//  LoginService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 6/5/2564 BE.
//

import Foundation
import Alamofire

class LoginService: BaseApi<LoginRequest, LoginResponse> {
    
    override func createUrlReq(_ encRequest: LoginRequest) -> URLRequestConvertible {
        return Router.Login(encRequest.toJSON()).apiModel
    }
    
    override func callServiceObject(request: LoginRequest, _ completionHandler: @escaping (Result<LoginResponse, KError>) -> Void) {
        
        super.executeObject(request: request, completionHandler)
    }
}
