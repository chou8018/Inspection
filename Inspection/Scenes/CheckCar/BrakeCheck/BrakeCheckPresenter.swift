//
//  BrakeCheckPresenter.swift
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

protocol BrakeCheckPresentationLogic
{
  func presentSomething(response: BrakeCheck.Something.Response)
}

class BrakeCheckPresenter: BrakeCheckPresentationLogic
{
  weak var viewController: BrakeCheckDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: BrakeCheck.Something.Response)
  {
    let viewModel = BrakeCheck.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
