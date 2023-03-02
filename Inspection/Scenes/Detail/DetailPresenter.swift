//
//  DetailPresenter.swift
//  Inspection
//
//  Created by Thanawat prathumset on 3/2/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailPresentationLogic
{
  func presentDetail(response: Detail.Model.Response)
}

class DetailPresenter: DetailPresentationLogic
{
  weak var viewController: DetailDisplayLogic?
  
  // MARK: Do something
  
  func presentDetail(response: Detail.Model.Response)
  {
    guard let item = response.item else { return }
    
    
    let vehicle = item.vehicle
    var detail = "\(vehicle?.buildYear ?? "")"
    detail += " \(vehicle?.make_BU ?? "")"
    detail += " \(vehicle?.model_BU ?? "")"
    detail += " \(vehicle?.variants ?? "")"
    
    let registration = vehicle?.registration?.trimWhiteSpace ?? ""
    let vin = vehicle?.vin?.trimWhiteSpace ?? ""
    let engineNumber = vehicle?.engineNumber?.trimWhiteSpace ?? ""
 
    
    let viewModel = Detail.Model.ViewModel(detail: detail.trimWhiteSpace.isEmpty ? "-" : detail,
                                           registration: registration.isEmpty ? "-" : registration,
                                           vin: vin.isEmpty ? "-" : vin,
                                           chassisNumber: engineNumber.isEmpty ? "-" : engineNumber)
    
    viewController?.displayDetail(viewModel: viewModel)
  }
}
