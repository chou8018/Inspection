//
//  LoginModels.swift
//  Inspection
//
//  Created by Thanawat prathumset on 1/2/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Login
{
  // MARK: Use cases
  
  enum getLogin
  {
    struct Request
    {
        var username : String
        var password : String
    }
    struct Response
    {
        var loginResponse: LoginResponse?
        var validateErrorMessage:String?
        var error:KErrorMessage?
        
    }
    struct ViewModel
    {
        var errorMessage:String?
    }
  }
}
