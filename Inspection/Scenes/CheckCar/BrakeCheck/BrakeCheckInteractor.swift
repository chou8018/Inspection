//
//  BrakeCheckInteractor.swift
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

protocol BrakeCheckBusinessLogic
{
  func doSomething(request: BrakeCheck.Something.Request)
}

protocol BrakeCheckDataStore
{
  //var name: String { get set }
}

class BrakeCheckInteractor: BrakeCheckBusinessLogic, BrakeCheckDataStore
{
  var presenter: BrakeCheckPresentationLogic?
  var worker: BrakeCheckWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: BrakeCheck.Something.Request)
  {
    worker = BrakeCheckWorker()
    worker?.doSomeWork()
    
    let response = BrakeCheck.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
