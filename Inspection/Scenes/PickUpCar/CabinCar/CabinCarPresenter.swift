//
//  CabinCarPresenter.swift
//  Inspection
//
//  Created by Thanawat prathumset on 8/2/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CabinCarPresentationLogic
{
  func presentSomething(response: CabinCar.Something.Response)
    func presentValidateMilesNumber(response: CabinCar.Something.Response)
    func presentKeyChecked(response: CabinCar.Something.Response)
    func presentRemoteChecked(response: CabinCar.Something.Response)
    func presentRemoteKeyChecked(response: CabinCar.Something.Response)
    func presentImmobilizerKeyChecked(response: CabinCar.Something.Response)
    func presentKeylessKeyChecked(response: CabinCar.Something.Response)
    func presentExpiredDayTime(response: CabinCar.Something.Response)
 
    func presentGearBoxList(response: CabinCar.Something.Response)
    func presentGearBoxText(response: CabinCar.Something.Response)
}

class CabinCarPresenter: CabinCarPresentationLogic
{
    
    
  weak var viewController: CabinCarDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: CabinCar.Something.Response)
  {
    let viewModel = CabinCar.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
    
    func presentValidateMilesNumber(response: CabinCar.Something.Response) {
        let viewModel = CabinCar.Something.ViewModel(validateMilesNumber: response.validateMilesNumber)
        viewController?.displayValidateMileNumber(viewModel: viewModel)
    }
    
    func presentKeyChecked(response: CabinCar.Something.Response) {
        let viewModel = CabinCar.Something.ViewModel(isKeyCheck: response.isKeyCheck)
        viewController?.displayKeyChecked(viewModel: viewModel)
    }
    
    func presentRemoteChecked(response: CabinCar.Something.Response) {
        let viewModel = CabinCar.Something.ViewModel(isRemoteCheck: response.isRemoteCheck)
        viewController?.displayRemoteChecked(viewModel: viewModel)
    }
    
    func presentRemoteKeyChecked(response: CabinCar.Something.Response) {
        let viewModel = CabinCar.Something.ViewModel(isRemoteKeyCheck: response.isRemoteKeyCheck)
        viewController?.displayRemoteKeyChecked(viewModel: viewModel)
    }
    
    func presentImmobilizerKeyChecked(response: CabinCar.Something.Response) {
        let viewModel = CabinCar.Something.ViewModel(isImmobilizerKeyCheck: response.isImmobilizerKeyCheck)
        viewController?.displayImmobiliserKeyChecked(viewModel: viewModel)
    }
    
    func presentKeylessKeyChecked(response: CabinCar.Something.Response) {
        let viewModel = CabinCar.Something.ViewModel(isKeylessKeyCheck: response.isKeylessKeyCheck)
        viewController?.displayKeylessKeyChecked(viewModel: viewModel)
    }
    
    func presentExpiredDayTime(response: CabinCar.Something.Response) {
        let viewModel = CabinCar.Something.ViewModel(dayTime: response.dayTime)
        viewController?.displayExpiredDateTime(viewModel: viewModel)
        
    }
   
    func presentGearBoxList(response: CabinCar.Something.Response) {
        if let error = response.error {
            let viewModel = CabinCar.Something.ViewModel(errorMessage: error.message)
            viewController?.displayErrorGearBoxList(viewModel: viewModel)
        }else{
            guard let gearBoxList = response.gearBoxList else { return }
            let gearBoxList_bu = gearBoxList.compactMap({ $0.desc_BU })
            
//            DataController.shared.receiverCarModel.gearboxListPart = gearBoxList_bu
//            var listAll = [String]()
//            for gear in gearBoxList {
//                if let gear_bu = gear.desc_BU {
//                    listAll.append(gear_bu)
//                }
//                if let items = gear.items {
//                    for item in items {
//                        if let gear_bu = item.desc_BU {
//                            listAll.append(gear_bu)
//                        }
//                    }
//                }
//            }
//            DataController.shared.receiverCarModel.gearboxListAll = listAll

            let viewModel = CabinCar.Something.ViewModel(gearBoxList_bu: gearBoxList_bu)
            viewController?.displayGearBoxList(viewModel: viewModel)
        }
        
    }
    
    func presentGearBoxText(response: CabinCar.Something.Response) {
        let viewModel = CabinCar.Something.ViewModel(gearBox_BU: response.gearBox_BU)
        viewController?.displayGearBoxText(viewModel: viewModel)
    }
}
