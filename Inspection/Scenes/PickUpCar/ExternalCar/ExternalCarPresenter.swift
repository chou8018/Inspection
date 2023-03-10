//
//  ExternalCarPresenter.swift
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

protocol ExternalCarPresentationLogic
{
  func presentSomething(response: ExternalCar.Something.Response)
    func presentCheckBoxTire(response: ExternalCar.Something.Response)
    func presentCheckBoxMagWheel(response: ExternalCar.Something.Response)
    func presentValidateNumber(response: ExternalCar.Something.Response)
    func presentCheckBoxNormalWheel(response: ExternalCar.Something.Response)
}

class ExternalCarPresenter: ExternalCarPresentationLogic
{
  weak var viewController: ExternalCarDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: ExternalCar.Something.Response)
  {
    let viewModel = ExternalCar.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
    
    func presentCheckBoxTire(response: ExternalCar.Something.Response) {
        let viewModel = ExternalCar.Something.ViewModel(isTire: response.isTire)
        viewController?.displayTireCheckBox(viewModel: viewModel)
        
    }
    func presentCheckBoxMagWheel(response: ExternalCar.Something.Response) {
        let viewModel = ExternalCar.Something.ViewModel(isMagWheel: response.isMagWheel)
        viewController?.displayMagWheelCheckBox(viewModel: viewModel)
    }
    
    
    func presentCheckBoxNormalWheel(response: ExternalCar.Something.Response) {
        
        let viewModel = ExternalCar.Something.ViewModel(isNormalWheel: response.isNormalWheel)
        
        viewController?.displayNormalWheelCheckBox(viewModel: viewModel)
    }
    
    
    func presentValidateNumber(response: ExternalCar.Something.Response) {
        
        let viewModel = ExternalCar.Something.ViewModel(validateNumberResult: response.validateNumberResult)
        
        viewController?.displayValidateResultTireTextField(viewModel: viewModel)
    }
    
}
