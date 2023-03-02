//
//  BookInPendingListService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 6/5/2564 BE.
//

import Foundation
import Alamofire

class BookInPendingListService : BaseApi<BookInPendingRequest , BookInListResponse> {
    
    override func createUrlReq(_ encRequest: BookInPendingRequest) -> URLRequestConvertible {
        return Router.bookInPendingList(encRequest.toJSON(), email: encRequest.email).apiModel
    }
    
    override func callServiceArray(request: BookInPendingRequest, _ completionHandler: @escaping (Result<[BookInListResponse], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
