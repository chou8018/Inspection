//
//  BookInListSearchService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 7/4/2564 BE.
//

import Foundation
import Alamofire


class BookInListSearchService: BaseApi<BookInSearchRequest , BookInListResponse> {
    override func createUrlReq(_ encRequest: BookInSearchRequest) -> URLRequestConvertible {
        
        return Router.bookInListSearch(encRequest.toJSON()).apiModel

    }
    
    override func callServiceArray(request: BookInSearchRequest, _ completionHandler: @escaping (Result<[BookInListResponse], KError>) -> Void) {
        
        super.executeArray(request: request, completionHandler)
    }
}
