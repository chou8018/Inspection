//
//  UINavigationController+extension.swift
//  Inspection
//
//  Created by Thanawat prathumset on 4/2/2564 BE.
//

import Foundation
import UIKit


extension UINavigationController {
    func popToViewController<T: UIViewController>(withType type: T.Type , animated : Bool) {
         for viewController in self.viewControllers {
             if viewController is T {
               self.popToViewController(viewController, animated: animated)
              return
         }
      }
   }
}
