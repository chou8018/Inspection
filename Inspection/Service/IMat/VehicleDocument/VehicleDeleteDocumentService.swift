//
//  VehicleDeleteDocumentService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 27/5/2564 BE.
//

import Foundation
import Alamofire

class VehicleDeleteDocumentService: BaseApi<VehicleDeleteDocumentRequest, VehicleDocumentResponse> {
 
    override func createUrlReq(_ encRequest: VehicleDeleteDocumentRequest) -> URLRequestConvertible {
        return Router.deleteVehicleDocument(encRequest.toJSON()).apiModel
    }
    
    override func callServiceObject(request: VehicleDeleteDocumentRequest, _ completionHandler: @escaping (Result<VehicleDocumentResponse, KError>) -> Void) {
        
        super.executeObject(request: request, completionHandler)
    }
}
