//
//  SearchByDataSource.swift
//  Inspection
//
//  Created by Thanawat prathumset on 3/2/2564 BE.
//

import Foundation
import UIKit

class SearchDataSource : NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    var searchByList : [String] = []
    var didSelectRow : [UIPickerView : Int] = [:]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return searchByList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return searchByList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didSelectRow[pickerView] = row
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
}
