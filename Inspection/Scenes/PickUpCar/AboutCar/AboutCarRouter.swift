//
//  AboutCarRouter.swift
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

@objc protocol AboutCarRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol AboutCarDataPassing
{
  var dataStore: AboutCarDataStore? { get }
}

class AboutCarRouter: NSObject, AboutCarRoutingLogic, AboutCarDataPassing
{
  weak var viewController: AboutCarBaseViewController?
  var dataStore: AboutCarDataStore?
  
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
  
  //func navigateToSomewhere(source: AboutCarViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: AboutCarDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}

//class AboutCarRouterNew: NSObject, AboutCarRoutingLogic, AboutCarDataPassing
//{
//  weak var viewController: AboutCarViewControllerNew?
//  var dataStore: AboutCarDataStore?
//}
