//
//  BaseApi.swift
//  iOSTest
//
//  Created by Thanawat prathumset on 1/2/2564 BE.
//

import Foundation
import ObjectMapper
import Alamofire
//import SDWebImageWebPCoder



class BaseApi<Request:BaseMappable , Response:BaseMappable>{
    
    func createUrlReq(_ encRequest: Request) -> URLRequestConvertible {
        preconditionFailure("Create url request must be overridden")
    }
    
    func callServiceObject(request: Request, _ completionHandler: @escaping (Result<Response , KError>) -> Void) {
    }
    func callServiceArray(request: Request, _ completionHandler: @escaping (Result<[Response] , KError>) -> Void) {
    }
    func callServiceUpload(request: Request,
                           _ uploadProgress: @escaping ((Double)->Void),
                           _ completionHandler: @escaping (Result<Response , KError>) ->Void) {
    }
    func callServiceUpload2(request: Request,
                            photoImage: PhotoCar.PhotoImage,
                           _ uploadProgress: @escaping ((Double)->Void),
                           _ completionHandler: @escaping (Result<Response , KError>) ->Void) {
    }
    
    
    func executeObject(request: Request, _ completionHandler: @escaping (Result<Response , KError>) -> Void) {
        
        let url = createUrlReq(request)
        AF.request(url).responseJSON { (response) in

            switch response.result {
               case .success(let value):
                    if let httpResponse = response.response, httpResponse.statusCode != 200 {
                        var errorMessage = ""
                        if let errorValue = value as? [String: Any] {
                            print("🔸 error \(errorValue)")
                            errorMessage = errorValue["message"] as? String ?? ""
                        }
                        completionHandler(.failure(.httpRespondError(httpResponse, errorMessage)))
                        return
                    }
                   guard let castingValue = value as? [String: Any] ,
                         let responseData = Mapper<Response>().map(JSON: castingValue) else {
                            completionHandler(.failure(.internalError(-2000)))
                            return
                   }
                    completionHandler(.success(responseData))
                
               case .failure(let error):
              

                    if let httpResponse = response.response,httpResponse.statusCode != 200 {
                         completionHandler(.failure(.httpRespondError(httpResponse)))
                        return
                    }
                    completionHandler(.failure(KError.httpAFError(error)))
               }
        }
    }
    
    func executeArray(request: Request, _ completionHandler: @escaping (Result<[Response] , KError>) -> Void) {
        
        let url = createUrlReq(request)
        AF.request(url).responseJSON { (response) in

            switch response.result {
               case .success(let value):
                    if let httpResponse = response.response, httpResponse.statusCode != 200 {
                        completionHandler(.failure(.httpRespondError(httpResponse)))
                        return
                    }
                    guard let castingArrayValue = value as? [[String: Any]] else {
                             completionHandler(.failure(.internalError(-2000)))
                             return
                    }
                    let responseArray = Mapper<Response>().mapArray(JSONArray: castingArrayValue)
                    completionHandler(.success(responseArray))
                
               case .failure(let error):
                    if let httpResponse = response.response, httpResponse.statusCode != 200 {
                        completionHandler(.failure(.httpRespondError(httpResponse)))
                        return
                    }
                    completionHandler(.failure(KError.httpAFError(error)))
               }
        }
    }
    
    //MARK: upload requet base64
    func executeServiceUploadObject(request: Request,
                                    _ uploadProgress: @escaping ((Double)->Void),
                                    _ completionHandler: @escaping (Result<Response , KError>) -> Void) {
        
        let url = createUrlReq(request)
        AF.request(url)
            .uploadProgress { (progress) in
                print("Upload Progress: \(progress.fractionCompleted)")
                uploadProgress(progress.fractionCompleted)
            }
            .responseJSON { (response) in

                switch response.result {
                   case .success(let value):
                        if let httpResponse = response.response, httpResponse.statusCode != 200 {
                            completionHandler(.failure(.httpRespondError(httpResponse)))
                            return
                        }
                       guard let castingValue = value as? [String: Any] ,
                             let responseData = Mapper<Response>().map(JSON: castingValue) else {
                                completionHandler(.failure(.internalError(-2000)))
                                return
                       }
                        completionHandler(.success(responseData))
                    
                   case .failure(let error):
                        if let httpResponse = response.response,httpResponse.statusCode != 200 {
                             completionHandler(.failure(.httpRespondError(httpResponse)))
                            return
                        }
                        completionHandler(.failure(KError.httpAFError(error)))
                }
            }
    }
    
    
    
    //MARK: upload multipart/form-data
    func uploadPhoto(request: Request,
                     photoImage: PhotoCar.PhotoImage,
                     _ uploadProgress: @escaping ((Double)->Void),
                     _ completionHandler: @escaping (Result<Response , KError>) ->Void) {
        
        guard let data = photoImage.image?.jpegData(compressionQuality: 1),
              let photoName = photoImage.url?.lastPathComponent else { return }
        //guard let data = SDImageWebPCoder.shared.encodedData(with: photoImage.image, format: .webP, options: nil),
        //              let photoName = photoImage.url?.lastPathComponent else { return }

        let url = createUrlReq(request)
        AF.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(data,
                                     withName: "photo", /// name receiver  "photoImage.name"
                                     fileName: photoName,
                                     //mimeType: "image/webp")
                                     mimeType: "image/jpeg")
          
            if let name = photoImage.name {
                multipartFormData.append(name.data(using: .utf8)!, withName: "name")
            }
            
            
        }, with: url)
        .uploadProgress { (progress) in
            print("Upload Progress: \(progress.fractionCompleted)")
            uploadProgress(progress.fractionCompleted)
        }.responseJSON { (response) in
//            if let httpResponse = response.response,httpResponse.statusCode != 200 {
//                 completionHandler(.failure(.httpRespondError(httpResponse)))
//                return
//            }
            switch response.result {
               case .success(let value):
                   guard let castingValue = value as? [String: Any] ,
                         let responseData = Mapper<Response>().map(JSON: castingValue) else {
                            completionHandler(.failure(.internalError(-2000)))
                            return
                   }
                    completionHandler(.success(responseData))
                
               case .failure(let error):
                    if let httpResponse = response.response, httpResponse.statusCode != 200 {
                        completionHandler(.failure(.httpRespondError(httpResponse)))
                        return
                    }
                    completionHandler(.failure(KError.httpAFError(error)))
               }
        }
    }
}
