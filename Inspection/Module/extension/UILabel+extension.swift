//
//  UILabel+extension.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 31/5/2564 BE.
//

import Foundation
import UIKit

extension UILabel {
    func validateLabel(_ valid:Bool?){
        guard let valid = valid else { return}
        self.textColor = valid ? .appPrimaryColor : .red
    }
}
