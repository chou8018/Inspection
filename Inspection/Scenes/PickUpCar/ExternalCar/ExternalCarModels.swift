//
//  ExternalCarModels.swift
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

enum ExternalCar
{
  // MARK: Use cases
  
  enum Something
  {
    struct Request
    {
        var tire : String?
        var validateNumber : String?
        var validateWheel : String?
        var validateNormalWheel : String?
    }
    struct Response
    {
        var isMagWheel : Bool?
        var isNormalWheel : Bool?
        var isTire : Bool?
        var validateNumberResult : String?
        var validateWheelResult : String?
    }
    struct ViewModel
    {
        var isMagWheel : Bool?
        var isNormalWheel : Bool?
        var isTire : Bool?
        var validateNumberResult : String?
        var validateWheelResult : String?
    }
  }
}
