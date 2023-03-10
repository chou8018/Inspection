//
//  CreateModelCodePresenter.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 23/6/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CreateModelCodePresentationLogic
{
  func presentSomething(response: CreateModelCode.Something.Response)
    func presentMakeList(response: CreateModelCode.Something.Response)
    func presentBodyList(response: CreateModelCode.Something.Response)
    func presentDriveList(response: CreateModelCode.Something.Response)
    func presentGearList(response: CreateModelCode.Something.Response)
    func presentGearBoxList(response: CreateModelCode.Something.Response)
    func presentFuelTypeList(response: CreateModelCode.Something.Response)
    func presentFuelDeliveryList(response: CreateModelCode.Something.Response)
    func presentMottoModelCode(response: CreateModelCode.Something.Response)
    func prrsentBuildYearList(response: CreateModelCode.Something.Response)
    func presentValidateField(response: CreateModelCode.Something.Response)
    func presentCreateModel(response: CreateModelCode.Something.Response)
    func presentJatoModelList(response: CreateModelCode.Something.Response)
    func presentJatoVaraintsList(response: CreateModelCode.Something.Response)
    func presentModelLO(response: CreateModelCode.Something.Response)
    
    func presentUpdateModel(response: CreateModelCode.Something.Response)
    
    func presentFormEditModel(response: CreateModelCode.Something.Response)
}

class CreateModelCodePresenter: CreateModelCodePresentationLogic
{
  weak var viewController: CreateModelCodeDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: CreateModelCode.Something.Response)
  {
    let viewModel = CreateModelCode.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
    
    func presentMakeList(response: CreateModelCode.Something.Response) {
        
        if let error = response.error {
            let viewModel = CreateModelCode.Something.ViewModel(errorMessage: error.message)
            viewController?.displayErrorMakeList(viewModel: viewModel)
        }else{
            guard let makeList = response.makeList else { return }
            let makeList_bu = makeList.compactMap({ $0.desc_BU })
            let viewModel = CreateModelCode.Something.ViewModel(makeList_bu: makeList_bu)
            viewController?.displayMakeList(viewModel: viewModel)
        }
    }
    
    func presentBodyList(response: CreateModelCode.Something.Response) {
        if let error = response.error {
            let viewModel = CreateModelCode.Something.ViewModel(errorMessage: error.message)
            viewController?.displayErrorBodyList(viewModel: viewModel)
        }else{
            guard let bodyList = response.bodyList else { return }
            let bodyList_bu = bodyList.compactMap({ $0.desc_BU })
            let viewModel = CreateModelCode.Something.ViewModel(bodyList_bu: bodyList_bu)
            viewController?.displayBodyList(viewModel: viewModel)
        }
    }
 
    func presentDriveList(response: CreateModelCode.Something.Response) {
        if let error = response.error {
            let viewModel = CreateModelCode.Something.ViewModel(errorMessage: error.message)
            viewController?.displayErrorDriveList(viewModel: viewModel)
        }else{
            guard let driveList = response.driveList else { return }
            let driveList_bu = driveList.compactMap({ $0.desc_BU })
            let viewModel = CreateModelCode.Something.ViewModel(driveList_bu: driveList_bu)
            viewController?.displayDriveList(viewModel: viewModel)
        }
        
    }
    
    func presentGearList(response: CreateModelCode.Something.Response) {
        guard let gearList = response.gearList else { return }
        let viewModel = CreateModelCode.Something.ViewModel(gearList_bu: gearList)
        viewController?.displayGearList(viewModel: viewModel)
    }
    
    
    func presentGearBoxList(response: CreateModelCode.Something.Response) {
        if let error = response.error {
            let viewModel = CreateModelCode.Something.ViewModel(errorMessage: error.message)
            viewController?.displayErrorGearBoxList(viewModel: viewModel)
        }else{
            guard let gearBoxList = response.gearBoxList else { return }
            let gearBoxList_bu = gearBoxList.compactMap({ $0.desc_BU })
            let viewModel = CreateModelCode.Something.ViewModel(gearBoxList_bu: gearBoxList_bu)
            viewController?.displayGearBoxList(viewModel: viewModel)
        }
        
    }
    
    func presentFuelTypeList(response: CreateModelCode.Something.Response) {
        if let error = response.error {
            let viewModel = CreateModelCode.Something.ViewModel(errorMessage: error.message)
            viewController?.displayErrorFuelTypeList(viewModel: viewModel)
        }else{
            guard let fuelTypeList = response.fuelTypeList else { return }
            let fuelTypeList_bu = fuelTypeList.compactMap({ $0.desc_BU })
            let viewModel = CreateModelCode.Something.ViewModel(fuelTypeList_bu: fuelTypeList_bu)
            viewController?.displayFuelTypeList(viewModel: viewModel)
        }
        
    }
    
    func presentFuelDeliveryList(response: CreateModelCode.Something.Response) {
        if let error = response.error {
            let viewModel = CreateModelCode.Something.ViewModel(errorMessage: error.message)
            viewController?.displayErrorFuelDeliveryList(viewModel: viewModel)
        }else{
            guard let fuelDeliveryList = response.fuelDeliveryList else { return }
            let fuelDeliveryList_bu = fuelDeliveryList.compactMap({ $0.desc_BU })
            let viewModel = CreateModelCode.Something.ViewModel(fuelDeliveryList_bu: fuelDeliveryList_bu)
            viewController?.displayFuelDeliveryList(viewModel: viewModel)
        }
        
    }
    
    func presentMottoModelCode(response: CreateModelCode.Something.Response) {
        guard let mottoModelCode = response.mottoModelCode else { return }
        let viewModel = CreateModelCode.Something.ViewModel(mottoModelCode: mottoModelCode)
        viewController?.displayMottoModelCode(viewModel: viewModel)
        
    }
    
    func prrsentBuildYearList(response: CreateModelCode.Something.Response) {
        guard let buildYearList = response.buildYearList else { return }
        let viewModel = CreateModelCode.Something.ViewModel(buildYearList: buildYearList)
        viewController?.displayBuildYear(viewModel: viewModel)
    }
    
    func presentValidateField(response: CreateModelCode.Something.Response) {
        if let validateErrorMessage = response.validateErrorMessage, !validateErrorMessage.trimWhiteSpace.isEmpty {
            let viewModel = CreateModelCode.Something.ViewModel(errorMessage: validateErrorMessage)
            viewController?.displayValidateError(viewModel: viewModel)
        }else{
            let viewModel = CreateModelCode.Something.ViewModel(modelCodeType: response.modelCodeType)
            viewController?.displayValidateSuccess(viewModel: viewModel)
        }
    }
    
    func presentCreateModel(response: CreateModelCode.Something.Response) {
        if let error = response.error {
            let viewModel = CreateModelCode.Something.ViewModel(errorMessage: error.message)
            viewController?.displayCreateModelError(viewModel: viewModel)
        }else{
            let resultMessage = "Create Success."
            let viewModel = CreateModelCode.Something.ViewModel(message: resultMessage)
            viewController?.displayCreateModelSuccess(viewModel: viewModel)
        }
    }
    
    func presentUpdateModel(response: CreateModelCode.Something.Response) {
        if let error = response.error {
            let viewModel = CreateModelCode.Something.ViewModel(errorMessage: error.message)
            viewController?.displayUpdateModelError(viewModel: viewModel)
        }else{
            let resultMessage = "Update Success."
            let viewModel = CreateModelCode.Something.ViewModel(message: resultMessage)
            viewController?.displayUpdateModelSuccess(viewModel: viewModel)
        }
    }
    
    func presentJatoModelList(response: CreateModelCode.Something.Response) {
        if let error = response.error {
            let viewModel = CreateModelCode.Something.ViewModel(errorMessage: error.message)
            viewController?.displayJatoCarModelError(viewModel: viewModel)
        }else{
            guard let jatoCarModelList = response.jatoCarModelList else { return }
            let modelList = jatoCarModelList.compactMap({ $0.model_BU })
            let viewModel = CreateModelCode.Something.ViewModel(jatoCarModelList_bu: modelList)
            viewController?.displayJatoCarModelList(viewModel: viewModel)
        }
    }
    
    
    func presentJatoVaraintsList(response: CreateModelCode.Something.Response) {
        if let error = response.error {
            let viewModel = CreateModelCode.Something.ViewModel(errorMessage: error.message)
            viewController?.displayJatoCarVaraintsError(viewModel: viewModel)
        }else{
            guard let jatoVaraintsList = response.jatoVaraintsList else { return }
            let modelList = jatoVaraintsList.compactMap({ $0.variants })
            let viewModel = CreateModelCode.Something.ViewModel(jatoVaraintsList_bu: modelList)
            viewController?.displayJatoCarVaraintslList(viewModel: viewModel)
        }
    }
    
    func presentModelLO(response: CreateModelCode.Something.Response) {
        let viewModel = CreateModelCode.Something.ViewModel(model_Lo: response.model_Lo)
        viewController?.displayJatoCarModelLo(viewModel: viewModel)
    }
    
    func presentFormEditModel(response: CreateModelCode.Something.Response) {
        let model = response.modelCodeTemplate
        let viewModel = CreateModelCode.Something.ViewModel(modelCodeTemplate: model,
            editMake: response.editMake,
            editBody: response.editBody,
            editFuelDelivery: response.editFuelDelivery,
            editFuelType: response.editFuelType,
            editGearBox: response.editGearBox,
            editDrive: response.editDrive)
        
        
        viewController?.displayFillDataFromEditModel(viewModel: viewModel)
    }
}
