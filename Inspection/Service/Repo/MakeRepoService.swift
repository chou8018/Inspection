//
//  SellerService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 5/3/2564 BE.
//

import Foundation
import Alamofire

class MakeRepoService : BaseApi<RepoModelRequest , MakeRepoResponse>{
    
    override func createUrlReq(_ encRequest: RepoModelRequest) -> URLRequestConvertible {
        return Router.createRepo(encRequest.toJSON()).apiModel
    }
    
    override func callServiceObject(request: RepoModelRequest, _ completionHandler: @escaping (Result<MakeRepoResponse, KError>) -> Void) {
        super.executeObject(request: request, completionHandler)
    }
}
