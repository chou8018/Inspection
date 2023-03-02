//
//  VehicleDocumentService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 24/5/2564 BE.
//

import Foundation
import Alamofire

class VehicleDocumentService: BaseApi<VehicleDocumentRequest, VehicleDocumentResponse> {
    override func createUrlReq(_ encRequest: VehicleDocumentRequest) -> URLRequestConvertible {
        return Router.vehicleDocument(encRequest.toJSON()).apiModel
    }
    
    override func callServiceObject(request: VehicleDocumentRequest, _ completionHandler: @escaping (Result<VehicleDocumentResponse, KError>) -> Void) {
        
        super.executeObject(request: request, completionHandler)
    }
}
