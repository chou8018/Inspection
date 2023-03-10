//
//  BodyCheckInteractor.swift
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

protocol BodyCheckBusinessLogic
{
  func doSomething(request: BodyCheck.Something.Request)
    func getProvince(request: BodyCheck.Something.Request)
}

protocol BodyCheckDataStore
{
  //var name: String { get set }
}

class BodyCheckInteractor: BodyCheckBusinessLogic, BodyCheckDataStore
{
  var presenter: BodyCheckPresentationLogic?
  var worker: BodyCheckWorker?
  //var name: String = ""
  
  // MARK: Do something
    var aboutWorker : AboutCarWorker?
    var provinceList : [ProvinceModel]?
    
    
  func doSomething(request: BodyCheck.Something.Request)
  {
    worker = BodyCheckWorker()
    worker?.doSomeWork()
    
    let response = BodyCheck.Something.Response()
    presenter?.presentSomething(response: response)
  }
    
    func getProvince(request: BodyCheck.Something.Request) {
        aboutWorker = AboutCarWorker()
        aboutWorker?.fetchProvince(completion: { [weak self] (response) in
            
            if let provinceList = response.provinceList {
                self?.provinceList = provinceList
            }
            let response = BodyCheck.Something.Response(provinceList: response.provinceList,
                                                        error: response.error)
            self?.presenter?.presentProvinceList(response: response)
        })
    }
}
