//
//  InspectionImageUploadService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 28/4/2564 BE.
//

import Foundation
import Alamofire

class InspectionImageUploadService: BaseApi<InspectionImageRequest , BaseResponse> {
    override func createUrlReq(_ encRequest: InspectionImageRequest) -> URLRequestConvertible {
        return Router.uploadInspectionImage(encRequest.toJSON()).apiModel
    }

    override func callServiceUpload(request: InspectionImageRequest, _ uploadProgress: @escaping ((Double) -> Void), _ completionHandler: @escaping (Result<BaseResponse, KError>) -> Void) {
        
        super.executeServiceUploadObject(request: request, uploadProgress, completionHandler)
    }
}
