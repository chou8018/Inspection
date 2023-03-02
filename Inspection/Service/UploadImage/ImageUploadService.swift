//
//  ImageUploadService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 29/4/2564 BE.
//

import Foundation
import Alamofire

class ImageUploadService : BaseApi<BaseRequest , BaseResponse> {
    override func createUrlReq(_ encRequest: BaseRequest) -> URLRequestConvertible {
        return Router.uploadInspectionImage(encRequest.toJSON()).apiModel
    }
    override func callServiceUpload2(request: BaseRequest, photoImage: PhotoCar.PhotoImage, _ uploadProgress: @escaping ((Double) -> Void), _ completionHandler: @escaping (Result<BaseResponse, KError>) -> Void) {
        
        super.uploadPhoto(request: request,
                          photoImage: photoImage,
                          uploadProgress, completionHandler)
    }
}
