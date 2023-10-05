//
//  BodyCheckPresenter.swift
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

protocol BodyCheckPresentationLogic
{
  func presentSomething(response: BodyCheck.Something.Response)
    func presentProvinceList(response: BodyCheck.Something.Response)
}

class BodyCheckPresenter: BodyCheckPresentationLogic
{
  weak var viewController: BodyCheckDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: BodyCheck.Something.Response)
  {
    let viewModel = BodyCheck.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
    
    func presentProvinceList(response: BodyCheck.Something.Response) {
        if let kError = response.error {
            let message = kError.message
            let viewModel = BodyCheck.Something.ViewModel(errorMessage: message)
            viewController?.displayShowProvinceError(viewModel: viewModel)
        }else{
            guard let provinceList = response.provinceList else { return }
            
            var values = provinceList.map({ $0.desc_LO ?? "" })
//            if !DataController.shared.isThaiLanguage() {
//                values = provinceList.map({ $0.desc_BU ?? "" })
//            }
            let viewModel = BodyCheck.Something.ViewModel(provinceList: values)
            viewController?.displayProvinceDropdown(viewModel: viewModel)
        }
    }
}
