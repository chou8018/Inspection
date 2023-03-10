//
//  SelectInspectionWorker.swift
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

typealias selectInspectionHandler = (SelectInspection.Default.Response)->()
class SelectInspectionWorker
{
  func doSomeWork()
  {
  }
    
    func fetchLocation(completion : @escaping selectInspectionHandler){
        
        showLoading()
        
        let baseRequest = BaseRequest()
        StorageLocationService().callServiceArray(request: baseRequest) { (result) in
            
            hideLoading()
            
            switch result {
            case .success(let response):
                let response = SelectInspection.Default.Response(storageList: response)
                completion(response)
                
            case .failure(let error):
                let response = SelectInspection.Default.Response(error : error.getMessage)
                completion(response)
            }
        }
    }
}
