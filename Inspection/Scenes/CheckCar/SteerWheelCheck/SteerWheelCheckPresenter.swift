//
//  SteerWheelCheckPresenter.swift
//  Inspection
//
//  Created by Thanawat prathumset on 15/2/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SteerWheelCheckPresentationLogic
{
  func presentSomething(response: SteerWheelCheck.Something.Response)
}

class SteerWheelCheckPresenter: SteerWheelCheckPresentationLogic
{
  weak var viewController: SteerWheelCheckDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: SteerWheelCheck.Something.Response)
  {
    let viewModel = SteerWheelCheck.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
