//
//  UploadInteractor.swift
//  Inspection
//
//  Created by Thanawat prathumset on 9/3/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol UploadBusinessLogic
{
  func uploadPhoto(request: Upload.Something.Request)
    func uploadPhotoByItem(request: Upload.Something.Request)
    func uploadSuccessCount(request: Upload.Something.Request)
    
    func updateStatus(request: Upload.Something.Request)
}

protocol UploadDataStore
{
  //var name: String { get set }
    var itemList : PhotoCarResponse { get set }
}

class UploadInteractor: UploadBusinessLogic, UploadDataStore
{
    var pickupWorker:PickUpCarWorker?
  var presenter: UploadPresentationLogic?
  var worker: UploadWorker?
  //var name: String = ""
    var itemList : PhotoCarResponse  = [:]
  // MARK: Do something
    var uploadList : [PhotoCar.PhotoImage] = []
    var uploadSuccessCount = 0
  
    var sectionArray = ["Front_B", "Engine_B", "Plate_B", "Chassis_B", "Interior_B", "Tray_B", "Side_B", "Back_B", "Gas_B", "Asset", "Damage"]
    
    var indexIterator:IndexingIterator<[PhotoCar.PhotoImage]>?
    
  func uploadPhoto(request: Upload.Something.Request)
  {

    sectionArray.forEach { sectionName in
        self.sortItemListBySection(uploadList: &self.uploadList, sectionName: sectionName)
    }
    print("🔸 upload que: \(uploadList.reduce("", {"\($0) , \($1.name)" }))")
    
    let response = Upload.Something.Response(uploadList: uploadList)
    presenter?.presentUploadView(response: response)
    

    indexIterator = uploadList.makeIterator()
    uploadByIndexIterator()
  }
    
    fileprivate func uploadByIndexIterator(){
        if let upload = indexIterator?.next() {
            self.upload(from: upload) { [weak self] in
                self?.uploadByIndexIterator()
            }
        }
        
    }
    
    fileprivate func sortItemListBySection(uploadList: inout [PhotoCar.PhotoImage],
                                           sectionName: String){
        if let photoList = itemList[sectionName].value {
            uploadList += photoList
                .filter({ $0.image != nil })
                .sorted(by: { $0.name!.compare($1.name!, options: .numeric) == .orderedAscending})
        }

    }
    
    
    func uploadPhotoByItem(request: Upload.Something.Request) {
        guard let uploadItem = request.uploadItem else { return }
        upload(from: uploadItem)
    }
    
    func uploadSuccessCount(request: Upload.Something.Request) {
        uploadSuccessCount += 1
        
        //check success all item
        if uploadList.count ==  uploadSuccessCount {
            //update
            pickupWorker = PickUpCarWorker()
            let bookinNo = DataController.shared.receiverCarModel.bookinNo
            pickupWorker?.updateStatusBookINType(bookinNO: bookinNo, completion: {[weak self] (pickUpResponse) in
                
                if let error = pickUpResponse.error {
                    
                    let response = Upload.Something.Response(error: error)
                    self?.presenter?.presentUploadSuccess(response: response)
                }else{
                    let response = Upload.Something.Response()
                    self?.presenter?.presentUploadSuccess(response: response)
                }
                
            })
        }
    }
    
    func updateStatus(request: Upload.Something.Request) {
        pickupWorker = PickUpCarWorker()
        let bookinNo = DataController.shared.receiverCarModel.bookinNo
        pickupWorker?.updateStatusBookINType(bookinNO: bookinNo, completion: {[weak self] (pickUpResponse) in
            
            if let error = pickUpResponse.error {
                
                let response = Upload.Something.Response(error: error)
                self?.presenter?.presentUploadSuccess(response: response)
            }else{
                let response = Upload.Something.Response()
                self?.presenter?.presentUploadSuccess(response: response)
            }
            
        })
    }
    
    func upload(from item: PhotoCar.PhotoImage, nextUpload: (()->Void)? = nil){
        
        worker = UploadWorker()
        
        var documentType: DocumentType =  .NORMAL
//        if let name = item.name, name.contains("Damage") {
//            documentType = .NORMAL
//        }else{
//            documentType = .NORMAL
//        }
        if DataController.shared.bookInType == .CARWRECK ||
            DataController.shared.bookInType == .MBIKEWRECK {
            documentType = .ONLINE
        }
        print("bookInTypeName: \(DataController.shared.bookInType.nameValue)")
        print("documentTypeId: \(documentType.documentTypeId)")
        
        worker?.uploadImage(item, dType: documentType, inProgress: {[weak self] (response) in
            self?.presenter?.presentProgress(response: response)

        }, completion: { [weak self] (response) in
            nextUpload?()
            if let error = response.error {
                let response = Upload.Something.Response(modelPhotoImage: item, error: error)
                self?.presenter?.presentUpload(response: response)
            }else{
                self?.removeByItem(deleteTarget: item)
                self?.presenter?.presentUpload(response: response)
            }
        })

    }
    
    fileprivate func removeByItem(deleteTarget: PhotoCar.PhotoImage){
        var itemList = DataController.shared.photoCarModel.itemList
        var sectionName = ""
        if let name = deleteTarget.name, let range = name.range(of: "_B") {
            sectionName = "\(name[..<range.lowerBound])_B"
        }
        if let name = deleteTarget.name, name.contains("Damage") {
            sectionName = "Damage"
        }
        if let name = deleteTarget.name, name.contains("Asset") {
            sectionName = "Asset"
        }
        
        
        removeItem(itemList: &itemList,
                   sectionName: sectionName,
                   deleteTarget: deleteTarget)
        
        DataController.shared.photoCarModel.itemList = itemList
        
    }
    fileprivate func removeItem(itemList: inout PhotoCarResponse,
                                   sectionName: String, deleteTarget: PhotoCar.PhotoImage) {
                       
       guard var modelList = itemList[sectionName] else{
           //not found
           return
       }
       if let target = modelList.firstIndex(where: { $0.name == deleteTarget.name }) {
        
           modelList.remove(at: target)
           itemList[sectionName] = modelList
           
       }
    }
    
}
