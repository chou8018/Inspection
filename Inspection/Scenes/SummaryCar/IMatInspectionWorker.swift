//
//  IMatInspectionWorker.swift
//  Inspection
//
//  Created by Thanawat prathumset on 17/5/2564 BE.
//

import Foundation
import UIKit


typealias responseIMatInspectionHandler = (_ response:SummaryCar.Something.Response) -> ()

enum DocumentType {
    case BOOKIN
    case INSPECTION
    case NORMAL
    case ONLINE
    
    var documentTypeId:Int { // online type 3, normal type 2
        switch self {
       
        case .BOOKIN:
            return 1
        case .INSPECTION:
            return 4
        case .NORMAL:
            return 2
        case .ONLINE:
            return 3
        
            
        }
    }
    
}
class IMatInspectionWorker {
    
    //MARK: retrive
    func retriveDocument(_ pdfImage:UIImage, dType:DocumentType,  completion: @escaping responseIMatInspectionHandler){
        
        showLoading()
        
        let bookInNumber = DataController.shared.receiverCarModel.bookinNo?.trimWhiteSpace
        let request = BookInDetailRequest(bookInNumber: bookInNumber)
        InspectionImageListService().callServiceArray(request: request) {[weak self] (results) in
            
            hideLoading()
            
            switch results {
            
            case .success(let imageList):
                var imageName = ""
                switch dType {
                case .BOOKIN:
                    imageName = "BookIn"
                case .INSPECTION:
                    imageName = "Inspection"
                default:
                    imageName = ""
                }
                if imageList.filter( { $0.imageName?.contains(imageName) ?? false }).count > 0 {
                    print("🔸Mapping ImageName:  \(imageName)")
                    self?.deleteDocument(pdfImage, imageName: imageName,
                                         dType: dType, completion: completion)
                }else{
                    self?.sendInspectionToIMAT(pdfImage, dType:dType, completion: completion)
                }
                
            case .failure(let error):
                if let errorCode = error.getMessage.errorCode , errorCode == 404 {
                    //ignored
                    self?.sendInspectionToIMAT(pdfImage, dType:dType, completion: completion)
                }else{
                    let response = SummaryCar.Something.Response(error: error.getMessage)
                    completion(response)
                }
            }
        }
        

        //        showLoading()
//        let vehicleId = DataController.shared.receiverCarModel.vehicleId.trimWhiteSpace
//
//        let request = VehicleGetDocumentRequest(vehicleId: vehicleId,
//                                                documentTypeID: dType.documentTypeId)
//        VehicleGetDocumentService().callServiceObject(request: request) {[weak self] results in
//
//            hideLoading()
//
//            switch results {
//
//            case .success(let documentResponse):
//                //exist
//                print("🔶retrive document \(documentResponse)")
//                let documentId = documentResponse.documentID
//                self?.deleteDocument(pdfImage, imageName: "", documentId: documentId, dType:dType,  completion: completion)
//
//            case .failure(let error):
//                if let errorCode = error.getMessage.errorCode , errorCode == 404 {
//                    self?.sendInspectionToIMAT(pdfImage, dType:dType, completion: completion)
//                }else{
//                    let response = SummaryCar.Something.Response(error: error.getMessage)
//                    completion(response)
//                }
//            }
//        }
    }
    //MARK: delete
    fileprivate func deleteDocument(_ pdfImage:UIImage, imageName:String, dType:DocumentType,  completion: @escaping responseIMatInspectionHandler){
        
        showLoading()
        
        let bookinNo = DataController.shared.receiverCarModel.bookinNo?.trimWhiteSpace
        let vehicleId = DataController.shared.receiverCarModel.vehicleId
        
        let request = InspectionImageDeleteRequest(bookInNumber: bookinNo,
                                                   imageName: imageName,
                                                   vehicleId: vehicleId,
                                                   imageTypeId: dType.documentTypeId)
        
        print("🔸deleteDocument: \(request.toJSON())")
        
        InspectionImageDeleteService().callServiceObject(request: request) { [weak self] (results) in
            
            hideLoading()
            
            switch results {
            
            case .success(let documentResponse):
                print("🔶delete document \(documentResponse)")
                self?.sendInspectionToIMAT(pdfImage, dType: dType, completion: completion)
            case .failure(let error):
                let response = SummaryCar.Something.Response(error: error.getMessage)
                completion(response)
            }
        }
        
//        let vehicleId = DataController.shared.receiverCarModel.vehicleId.trimWhiteSpace
//        let request = VehicleDeleteDocumentRequest(documentId: documentId,
//                                                   vehicleId: vehicleId)
//
//        VehicleDeleteDocumentService().callServiceObject(request: request) {[weak self] results in
//
//            hideLoading()
//
//            switch results {
//
//            case .success(let documentResponse):
//                print("🔶delete document \(documentResponse)")
//                self?.sendInspectionToIMAT(pdfImage, dType: dType, completion: completion)
//
//            case .failure(let error):
//                let response = SummaryCar.Something.Response(error: error.getMessage)
//                completion(response)
//            }
//        }
    }
    //MARK: create
    fileprivate func sendInspectionToIMAT(_ pdfImage:UIImage, dType:DocumentType,  completion: @escaping responseIMatInspectionHandler){
        
       
        showLoading()
        
        let pdfImageData = pdfImage.toBase64String()
        
//        let createUser = DataController.shared.getUser()
        
        let modelReceiver = DataController.shared.receiverCarModel
        let vehicleId = modelReceiver.vehicleId.trimWhiteSpace
        let bookInNumber = modelReceiver.bookinNo?.trimWhiteSpace
        
        var imageName = ""
        var documentDescription_BU = ""
        
        switch dType {
        case .BOOKIN:
            documentDescription_BU = "Book In & Inspection Report"
            imageName = "BookIn"
        case .INSPECTION:
            documentDescription_BU = "Inspection"
            imageName = "Inspection"
        default:
            documentDescription_BU = ""
            imageName = ""
        }
        
        
        
        let inspectionImage = InspectionImage(bookInNumber: bookInNumber,
                                              vehicleId: vehicleId,
                                              imageTypeId: dType.documentTypeId,
                                              imageDescTh: documentDescription_BU,
                                              imageDescEn: documentDescription_BU,
                                              imageName: imageName,
                                              imagePath: "",
                                              damageDesc: "",
                                              damageSize: "",
                                              damageType: "")
        
        let request = InspectionImageRequest(inspectionImage: inspectionImage,
                                             base64String: pdfImageData)
        
        print("❤️🐶 InspectionImageUpload request: \(inspectionImage.toJSON()) ❤️🐶")
        
        InspectionImageUploadService().callServiceUpload(request: request) { (progress) in
//ignored
//            let progressModel = Upload.ProgressModel(name: photoImage.name ?? "", progress: progress)
//            let response = Upload.Something.Response(progressModel: progressModel)
//            inProgress(response)

        } _: { results in
            
            hideLoading()
            
            switch results {

            case .success(let documentResponse):
                print("🔶create document \(documentResponse) 🔶")
                let response = SummaryCar.Something.Response()
                completion(response)
                break
            case .failure(let kError):
                let response = SummaryCar.Something.Response(error: kError.getMessage)
                completion(response)
            }
        }
        
//        let request = VehicleDocumentRequest(vehicleId: vehicleId,
//                                             documentFile: pdfImageData,
//                                             createUser: createUser,
//                                             imageType: "JPG",
//                                             documentTypeID: dType.documentTypeId,
//                                             documentDeleted: nil,
//                                             documentDescription_BU: documentDescription_BU)
//
//
//        VehicleDocumentService().callServiceObject(request: request) { results in
//
//            hideLoading()
//
//            switch results {
//
//            case .success(let documentResponse):
//                print("🔶create document \(documentResponse) 🔶")
//                let response = SummaryCar.Something.Response(documentResponse: documentResponse)
//                completion(response)
//
//            case .failure(let error):
//                let response = SummaryCar.Something.Response(error: error.getMessage)
//                completion(response)
//            }
//        }
    }
}
