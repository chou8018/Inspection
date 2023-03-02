//
//  MotorcycleCheckModels.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 20/9/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum MotorcycleCheck
{
  // MARK: Use cases
  
  enum Something
  {
    struct Request
    {
        var decimalNumber : String?
    }
    struct Response
    {
        var decimalNumber : String?
        var provinceList : [ProvinceModel]?
        var error: KErrorMessage?
    }
    struct ViewModel
    {
        var frontTreadDepthValidNumber : String?
        var rearTreadDepthValidNumber : String?
        var provinceList : [String]?
        var errorMessage: String?
    }
  }
}
