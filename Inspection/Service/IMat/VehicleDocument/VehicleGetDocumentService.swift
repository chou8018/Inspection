//
//  VehicleGetDocumentServicee.swift
//  Inspection
//
//  Created by Thanawat prathumset on 27/5/2564 BE.
//

import Foundation
import Alamofire

class VehicleGetDocumentService : BaseApi<VehicleGetDocumentRequest , VehicleDocumentResponse> {
    
    override func createUrlReq(_ encRequest: VehicleGetDocumentRequest) -> URLRequestConvertible {
        return Router.getVehicleDocument(encRequest.toJSON()).apiModel
    }
    
    override func callServiceObject(request: VehicleGetDocumentRequest, _ completionHandler: @escaping (Result<VehicleDocumentResponse, KError>) -> Void) {
        
        super.executeObject(request: request, completionHandler)
    }
    
    
}
