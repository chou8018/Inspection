//
//  SparePartsCarInteractor.swift
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

protocol SparePartsCarBusinessLogic
{
  func doSomething(request: SparePartsCar.Something.Request)
    func tireSpareCheckBox(request: SparePartsCar.Something.Request)
}

protocol SparePartsCarDataStore
{
  //var name: String { get set }
}

class SparePartsCarInteractor: SparePartsCarBusinessLogic, SparePartsCarDataStore
{
  var presenter: SparePartsCarPresentationLogic?
  var worker: SparePartsCarWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: SparePartsCar.Something.Request)
  {
    worker = SparePartsCarWorker()
    worker?.doSomeWork()
    
    let response = SparePartsCar.Something.Response()
    presenter?.presentSomething(response: response)
  }
    
    
    func tireSpareCheckBox(request: SparePartsCar.Something.Request) {
        let tireSpare = request.tireSpare
        
        let isTireSpare = tireSpare?.trimWhiteSpace.isEmpty ?? false
        let response = SparePartsCar.Something.Response(isTireSpare: !isTireSpare)
        presenter?.presentCheckBoxTireSpare(response: response)
    }
}
