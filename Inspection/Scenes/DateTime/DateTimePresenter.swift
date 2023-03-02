//
//  DateTimePresenter.swift
//  Inspection
//
//  Created by Thanawat prathumset on 17/2/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DateTimePresentationLogic
{
  func presentSomething(response: DateTime.Something.Response)
    func presentDateFormat(response: DateTime.Something.Response)
    func presentDateToPicker(response: DateTime.Something.Response)
}

class DateTimePresenter: DateTimePresentationLogic
{
  weak var viewController: DateTimeDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: DateTime.Something.Response)
  {
    let viewModel = DateTime.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
   
    
    func presentDateToPicker(response: DateTime.Something.Response) {
        let viewModel = DateTime.Something.ViewModel(currentDate: response.currentDate)
        viewController?.displayCurrentDateToPicker(viewModel: viewModel)
    }
    func presentDateFormat(response: DateTime.Something.Response) {
        let dateString = "\(response.dateTuple?.day ?? "") \(response.dateTuple?.time ?? "")"
        let viewModel = DateTime.Something.ViewModel(dateString: dateString)
        viewController?.displayDateFormatOnValueChanged(viewModel: viewModel)
    }
    
}
