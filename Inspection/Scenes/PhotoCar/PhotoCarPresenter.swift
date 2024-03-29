//
//  PhotoCarPresenter.swift
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

protocol PhotoCarPresentationLogic
{
  func presentSomething(response: PhotoCar.Something.Response)
    func presentReceiverDayTimeInspection(response: PhotoCar.Something.Response)
    func presentImageBySection(response: PhotoCar.Something.Response)
    func presentUpload(response: PhotoCar.Something.Response)
    
    func presentImageDelete(response: PhotoCar.Something.Response)
    
    func presentUpdateRequireSection(response: PhotoCar.Something.Response)
    
    func presentUpdateCheckBox(response: PhotoCar.Something.Response)
    
    func presentSendToIMAT(response: PhotoCar.Something.Response)
    
    func presentDisplayImageView(response: PhotoCar.Something.Response)
    func presentValidateSendToIMAT(response: PhotoCar.Something.Response)
}

class PhotoCarPresenter: PhotoCarPresentationLogic
{
  weak var viewController: PhotoCarDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: PhotoCar.Something.Response)
  {
    let viewModel = PhotoCar.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
    
    func presentReceiverDayTimeInspection(response: PhotoCar.Something.Response) {
        let viewModel = PhotoCar.Something.ViewModel(dayTime: response.dayTime)
        viewController?.displayReceiverDayTimeInspection(viewModel: viewModel)
    }
    
    func presentImageBySection(response: PhotoCar.Something.Response) {
        if let error = response.error {
            let viewModel = PhotoCar.Something.ViewModel(errorMessage : error.message)
            viewController?.displayErrorFetchList(viewModel: viewModel)
        }else{
            var requiredSection:[Int] = []
            if let hasSection = response.hasSection {
                var dic: [String:Int] = [:]
                for item in hasSection {
                    let sectionName = item.0
                    let sectionPosition = item.1
                    
                    dic[sectionName] = sectionPosition
                }

                for item in dic {
                    requiredSection.append(Int(item.value))
                }
                for item in dic {
                    print("🔸 \(item)")
                }
            }
            
            let viewModel = PhotoCar.Something.ViewModel(imageList: response.imageList, requiredSection: requiredSection)
            viewController?.displayCollectionImageBySection(viewModel: viewModel)
        }
       
    }
    
    func presentImageDelete(response: PhotoCar.Something.Response) {
        if let error = response.error {
            let viewModel = PhotoCar.Something.ViewModel(errorMessage : error.message)
            viewController?.displayErrorDelete(viewModel: viewModel)
        }
    }
    
    func presentUpload(response: PhotoCar.Something.Response) {
        guard let isPhoto = response.isPhoto else { return }
        
        guard let _ = DataController.shared.receiverCarModel.bookinNo else {
            let alertPhotoMessage = "กรุณาบันทึกรับมอบรถก่อน"
            let viewModel = PhotoCar.Something.ViewModel(alertPhotoMessage : alertPhotoMessage)
            viewController?.displayAlertMessage(viewModel: viewModel)
            return
        }
        
        /// CASE IS NOT CARWRECK
        let isCarWreck = DataController.shared.bookInType == .CARWRECK || DataController.shared.bookInType == .MBIKEWRECK 
        
        if !isCarWreck {
            let isCreateInspection = DataController.shared.inspectionCarModel.isCreate
            if !isCreateInspection {
                let alertPhotoMessage = "กรุณาทำการตรวจสภาพก่อน"
                let viewModel = PhotoCar.Something.ViewModel(alertPhotoMessage : alertPhotoMessage)
                viewController?.displayAlertMessage(viewModel: viewModel)
                return
            }
        }
        
        let vehicleId = DataController.shared.receiverCarModel.vehicleId.trimWhiteSpace
        if vehicleId.isEmpty {
            let alertPhotoMessage = "กรุณาทำการ Send Book-in ก่อน"
            let viewModel = PhotoCar.Something.ViewModel(alertPhotoMessage : alertPhotoMessage)
            viewController?.displayAlertMessage(viewModel: viewModel)
            return
        }
        
        if isPhoto {
            let viewModel = PhotoCar.Something.ViewModel()
            viewController?.displayUploadProgress(viewModel: viewModel)
        }else{
            let viewModel = PhotoCar.Something.ViewModel(alertPhotoMessage : "กรุณาเพิ่มรูปถ่าย")
            viewController?.displayAlertMessage(viewModel: viewModel)
        }
        
    }
    
    func presentUpdateRequireSection(response: PhotoCar.Something.Response) {
        let viewModel = PhotoCar.Something.ViewModel(updateSection: response.updateSection,
                                                     isSkip: response.isSkip)
        viewController?.displayUpdateRequiredButton(viewModel: viewModel)
    }
    
    func presentUpdateCheckBox(response: PhotoCar.Something.Response) {
        let viewModel = PhotoCar.Something.ViewModel(isCheck: response.isCheck)
        viewController?.displayUpdateCheckBox(viewModel: viewModel)
    }
    
    
    func presentSendToIMAT(response: PhotoCar.Something.Response) {
        if let error = response.error {
            let viewModel = PhotoCar.Something.ViewModel(errorMessage: error.message)
            viewController?.displaySendInsectionIMATError(viewModel: viewModel)
        }else{
            let viewModel = PhotoCar.Something.ViewModel()
            viewController?.displaySendInsectionIMATSuccess(viewModel: viewModel)
        }
    }
    
    func presentDisplayImageView(response: PhotoCar.Something.Response) {
        let viewModel = PhotoCar.Something.ViewModel()
        viewController?.displayShowImageView(viewModel: viewModel)
    }
    
    func presentValidateSendToIMAT(response: PhotoCar.Something.Response) {
        let viewModel = PhotoCar.Something.ViewModel(isEnableSendToIMAP: response.isEnableSendToIMAP)
        viewController?.displayActionEventSuccess(viewModel: viewModel)
    }
}
