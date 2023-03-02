//
//  BookInListService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 5/4/2564 BE.
//

import Foundation
import Alamofire

class BookInListService : BaseApi<BaseRequest , BookInListResponse>{
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.bookInList(encRequest.toJSON()).apiModel
    }
    
    override func callServiceArray(request: BaseRequest, _ completionHandler: @escaping (Result<[BookInListResponse], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
