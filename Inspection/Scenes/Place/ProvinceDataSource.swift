//
//  ProvinceDataSource.swift
//  Inspection
//
//  Created by Thanawat prathumset on 2/2/2564 BE.
//

import Foundation
import UIKit

class ProvinceDataSource : NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    var locationList : [StorageLocationModel]?
    var plantLocationList : [PlantResponse]?
    var didSelectRow : [UIPickerView : StorageLocationModel] = [:]
    var receiverDidSelectRow : [UIPickerView : PlantResponse] = [:]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let locationList = locationList {
            return locationList.count
        }
        if let plantlocation = plantLocationList {
            return plantlocation.count
        }
        
        return 0
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if let locationList = locationList {
            return locationList[row].location
        }
        if let plantlocation = plantLocationList {
            return plantlocation[row].desc_BU
        }
        
        return ""
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let locationList = locationList {
            didSelectRow[pickerView] = locationList[row]
        }
        if let plantlocation = plantLocationList {
            receiverDidSelectRow[pickerView] = plantlocation[row]
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
    
}
