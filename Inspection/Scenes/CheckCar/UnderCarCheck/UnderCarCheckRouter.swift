//
//  UnderCarCheckRouter.swift
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

@objc protocol UnderCarCheckRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol UnderCarCheckDataPassing
{
  var dataStore: UnderCarCheckDataStore? { get }
}

class UnderCarCheckRouter: NSObject, UnderCarCheckRoutingLogic, UnderCarCheckDataPassing
{
  weak var viewController: UnderCarCheckViewController?
  var dataStore: UnderCarCheckDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: UnderCarCheckViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: UnderCarCheckDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
