//
//  ModelCodeRouter.swift
//  Inspection
//
//  Created by Thanawat prathumset on 9/3/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol ModelCodeRoutingLogic
{
  func routeToeditModelCodeSegue(segue: UIStoryboardSegue?)
}

protocol ModelCodeDataPassing
{
  var dataStore: ModelCodeDataStore? { get }
}

class ModelCodeRouter: NSObject, ModelCodeRoutingLogic, ModelCodeDataPassing
{
  weak var viewController: ModelCodeViewController?
  var dataStore: ModelCodeDataStore?
  
  // MARK: Routing
  
  func routeToeditModelCodeSegue(segue: UIStoryboardSegue?)
  {
    if let segue = segue {
      let destinationVC = segue.destination as! CreateModelCodeViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    } else {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let destinationVC = storyboard.instantiateViewController(withIdentifier: "CreateModelCodeViewController") as! CreateModelCodeViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToSomewhere(source: dataStore!, destination: &destinationDS)
      navigateToSomewhere(source: viewController!, destination: destinationVC)
    }
  }

  // MARK: Navigation
  
  func navigateToSomewhere(source: ModelCodeViewController, destination: CreateModelCodeViewController)
  {
    source.show(destination, sender: nil)
  }
  
  // MARK: Passing data
  
  func passDataToSomewhere(source: ModelCodeDataStore, destination: inout CreateModelCodeDataStore)
  {
    destination.editModelCodeTemplate = source.editModelCodeTemplate
    
  }
}
