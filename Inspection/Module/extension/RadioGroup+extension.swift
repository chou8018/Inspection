//
//  RadioGroup+extension.swift
//  Inspection
//
//  Created by Thanawat prathumset on 20/5/2564 BE.
//

import Foundation
import UIKit
import RadioGroup

extension RadioGroup {
    func setEnableView(isEnable: Bool) {
        self.isEnabled = isEnable
        self.selectedColor = isEnable ? .orangeColor : .gullgray
        self.selectedTintColor = isEnable ? .orangeColor : .gullgray
    }
    func setValidateView(_ valid: Bool?) {
        guard let valid = valid else { return }
        self.tintColor = valid ? .appPrimaryColor : .red
        self.titleColor = valid ? .appPrimaryColor : .red
    }
}
