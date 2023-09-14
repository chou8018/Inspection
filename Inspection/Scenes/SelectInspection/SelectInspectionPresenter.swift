//
//  SelectInspectionPresenter.swift
//  Inspection
//
//  Created by Thanawat prathumset on 2/2/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SelectInspectionPresentationLogic
{
  func presentTextDisplay(response: SelectInspection.Default.Response)
    func presentFetchLocation(response: SelectInspection.Default.Response)
    func presentFetchPlantLocation(response: SelectInspection.Default.Response)
}

class SelectInspectionPresenter: SelectInspectionPresentationLogic
{
  weak var viewController: SelectInspectionDisplayLogic?
  
  // MARK: Do something
  
  func presentTextDisplay(response: SelectInspection.Default.Response)
  {
     
      let resultTextPlace = "\(String.localized("select_inspection_plant_label")) - \(response.selectStoreName?.location ?? "-")"
    
    let range2 = (resultTextPlace as NSString).range(of: "\(String.localized("select_inspection_plant_label")) -")
    let attr = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25),
                NSAttributedString.Key.foregroundColor: UIColor.white]
    
    let mutableAttributedString = NSMutableAttributedString(string: resultTextPlace,
                                                            attributes: attr)
    
    mutableAttributedString.addAttribute(NSAttributedString.Key.font,
                                         value: UIFont.systemFont(ofSize: 18), range: range2)
    
    let viewModel = SelectInspection.Default.ViewModel(resultTextPlace: mutableAttributedString)
    viewController?.displayResultTextPlace(viewModel: viewModel)
    
    
    let resultTextPlace2 = "\(String.localized("select_inspection_place_label")) - \(response.selectReceiveName?.desc_BU ?? "-")  "


    let range1 = (resultTextPlace2 as NSString).range(of: "\(String.localized("select_inspection_place_label")) -")
    
    let mutableAttributedString2 = NSMutableAttributedString(string: resultTextPlace2,
                                                            attributes: attr)
    
    mutableAttributedString2.addAttribute(NSAttributedString.Key.font,
                                         value: UIFont.systemFont(ofSize: 18), range: range1)
    
      let viewModelPlant = SelectInspection.Default.ViewModel(resultTextPlace: mutableAttributedString2,isCanSelect: response.isCanSelect)
    viewController?.displayResultTextPlacePlant(viewModel: viewModelPlant)
  
  }
    
    
    func presentFetchLocation(response: SelectInspection.Default.Response) {
        
        if let error = response.error {
            let viewModel = SelectInspection.Default.ViewModel(errorMessage: error.message)
            viewController?.displayErrorMessage(viewModel: viewModel)
        }else{
            guard let locationList = response.storageList else { return }
            let resultTextPlace = "\(String.localized("select_inspection_plant_label")) - \(locationList.first?.location ?? "-")"
            
            let range2 = (resultTextPlace as NSString).range(of: "\(String.localized("select_inspection_plant_label")) -")
            let attr = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25),
                        NSAttributedString.Key.foregroundColor: UIColor.white]
            
            let mutableAttributedString = NSMutableAttributedString(string: resultTextPlace,
                                                                    attributes: attr)
            
            mutableAttributedString.addAttribute(NSAttributedString.Key.font,
                                                 value: UIFont.systemFont(ofSize: 18), range: range2)
            
            let viewModel = SelectInspection.Default.ViewModel(resultTextPlace: mutableAttributedString)
            viewController?.displayResultTextPlace(viewModel: viewModel)
        }
        
        
    }
    
    func presentFetchPlantLocation(response: SelectInspection.Default.Response) {
        
        if let error = response.error {
            let viewModel = SelectInspection.Default.ViewModel(errorMessage: error.message)
            viewController?.displayPlantErrorMessage(viewModel: viewModel)
        }else{
            guard let locationList = response.plantLocationList else { return }
            let resultTextPlace = "\(String.localized("select_inspection_place_label")) - \(locationList.first?.desc_BU ?? "-")  "


            let range1 = (resultTextPlace as NSString).range(of: "\(String.localized("select_inspection_place_label")) -")
            let attr = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25),
                        NSAttributedString.Key.foregroundColor: UIColor.white]
            
            let mutableAttributedString = NSMutableAttributedString(string: resultTextPlace,
                                                                    attributes: attr)
            
            mutableAttributedString.addAttribute(NSAttributedString.Key.font,
                                                 value: UIFont.systemFont(ofSize: 18), range: range1)

            let viewModel = SelectInspection.Default.ViewModel(resultTextPlace: mutableAttributedString)
            viewController?.displayResultTextPlacePlant(viewModel: viewModel)
        }
        
        
    }
}
