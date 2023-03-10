//
//  PhotoCarWorker.swift
//  Inspection
//
//  Created by Thanawat prathumset on 4/2/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

typealias photoCarWorkerHandler = (PhotoCar.Something.Response) -> ()
class PhotoCarWorker
{
    
    
    func deletePhoto(from imageName:String?, dType:DocumentType,  completion: @escaping photoCarWorkerHandler){
        guard let imageName = imageName?.trimWhiteSpace else { return }
        
        showLoading()
        
        let bookinNo = DataController.shared.receiverCarModel.bookinNo?.trimWhiteSpace
        let vehicleId = DataController.shared.receiverCarModel.vehicleId
        
        let request = InspectionImageDeleteRequest(bookInNumber: bookinNo,
                                                   imageName: imageName,
                                                   vehicleId: vehicleId,
                                                   imageTypeId: dType.documentTypeId)
        
        print("🔸 \(request.toJSON())")
        
        InspectionImageDeleteService().callServiceObject(request: request) { (results) in
            
            hideLoading()
            
            switch results {
            
            case .success(_):
                let response = PhotoCar.Something.Response()
                completion(response)
            case .failure(let error):
                let response = PhotoCar.Something.Response(error: error.getMessage)
                completion(response)
            }
        }
    }
    
    
    func fetchInspectionImageList(from bookInNumber:String? , completion: @escaping photoCarWorkerHandler){
        guard let bookInNumber = bookInNumber?.trimWhiteSpace else { return }
        print("❤️🐶 fetch ImageList bookInNumber: \(bookInNumber) ❤️🐶")
        
        showLoading()
        
        let request = BookInDetailRequest(bookInNumber: bookInNumber)
        InspectionImageListService().callServiceArray(request: request) { (results) in
            
            hideLoading()
            
            switch results {
            
            case .success(let imageList):
                let damageImageLists = imageList.filter { model in
                    if let name = model.imageName, name.contains("Damage") {
                        return true
                    }
                    return false
                }
                DataController.shared.photoCarModel.damageItemLists = damageImageLists
                print("photoCarModel damageImageLists \(damageImageLists.count)")
                let response = PhotoCar.Something.Response(inspectionImageList: imageList)
                completion(response)
            
                
            case .failure(let error):
                if let errorCode = error.getMessage.errorCode , errorCode == 404 {
                    //ignored
                    let response = PhotoCar.Something.Response()
                    completion(response)
                }else{
                    let response = PhotoCar.Something.Response(error: error.getMessage)
                    completion(response)
                }
            }
        }
    }
}
