//
//  UIColor+extension.swift
//  Inspection
//
//  Created by Thanawat prathumset on 1/2/2564 BE.
//

import Foundation
import UIKit

extension UIColor {
    
    static var appPrimaryColor : UIColor {
        return UIColor(named: "primary_color") ?? clear
    }
    static var eastBayColor : UIColor {
        return UIColor(named: "eastBay") ?? clear
    }
    static var gullgray : UIColor {
        return UIColor(named: "gullgray") ?? clear
    }
    static var orangeColor : UIColor {
        return UIColor(named: "orange") ?? clear
    }
    static var saffronColor : UIColor {
        return UIColor(named: "saffron") ?? clear
    }
    static var galleryColor : UIColor {
        return UIColor(named: "gallery") ?? clear
    }
    static var errorColor : UIColor {
        return UIColor(named: "bittersweet") ?? clear
    }
}
