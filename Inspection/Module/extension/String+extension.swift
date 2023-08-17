//
//  String+extension.swift
//  Inspection
//
//  Created by Thanawat prathumset on 10/2/2564 BE.
//

import Foundation
import UIKit

extension String {
    func toInt() -> Int {
        return Int(self) ?? 0
    }
    func toDouble() -> Double {
        return Double(self) ?? 0.0
    }
    var trimWhiteSpace : String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var dropLast : String {
        return String(dropLast())
    }
    
    func isValidNumber() -> Bool {
        let mobileRegEx = "^[0-9]*$"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", mobileRegEx)
        return emailPred.evaluate(with: self)
    }
    func isValidNumberDouble() -> Bool {
        let mobileRegEx = "^[0-9]+\\.?[0-9]*$"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", mobileRegEx)
        return emailPred.evaluate(with: self)
    }
    func validateLength(size : (min : Int, max : Int)) -> Bool {
        return (size.min...size.max).contains(self.count)
    }


    func isValidMobile10Digit() -> Bool {
        let mobileRegEx = "^0[0-9]{9,9}$"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", mobileRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidCharactor() -> Bool {
        let mobileRegEx = "^[a-zA-Zก-ฮ0-9]*"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", mobileRegEx)
        return emailPred.evaluate(with: self)
    }
    
    var decimal : String {
        let number = self.toInt()
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number) ) ?? self.trimWhiteSpace
    }
    
    
    
    var pdfValidateString : String {
        return self.trimWhiteSpace.isEmpty ? "-" : self.trimWhiteSpace
    }
    var pdfValidateString2 : String {
        return self.trimWhiteSpace.isEmpty ? "" : self.trimWhiteSpace
    }
    
    func pdfReFormString(title:String) -> String {
        let newString = self.replacingOccurrences(of: "\n", with: "")
        let offset = title.count
        var count = 0
        return newString.reduce("") { (result, character) -> String in
            count += 1
            if count%(110 - offset) == 0 {
                return result + "\n\(character)"
            }
            return result + "\(character)"
        }
    }
    
     
    var grCodeIDValue :  String? {
        if  let url = URL(string: self.trimWhiteSpace) {
            let urlStr = url.absoluteString
             print(urlStr)
            // Parse the custom URL as per your requirement.
            let component = urlStr.components(separatedBy: "=")
            if component.count > 1, let first = component.first, let id = component.last {
                if first == "inspectionandbookin://id" {
                    return id
                }else{
                    return nil
                }
            }
        }
        return nil
    }
    
    func base64StringToImage() -> UIImage? {
        guard let imageData = Data(base64Encoded: self),
              let image = UIImage(data: imageData)  else { return nil }
        return image
    }
    
    func toJSON() -> Any? {
           guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
           return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
       }
}

extension String {
    
    static func localized(_ key: String, comment defaultValue: String = "") -> String {
        
        if let languageCode = Locale.current.languageCode,
           let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
           
            let bundle = Bundle(path: path) {
            
            return NSLocalizedString(
                key,
                tableName: "Localizable",
                bundle: bundle,
                value: NSLocalizedString(key, comment: defaultValue),
                comment: ""
            )
        }
        
        return NSLocalizedString(key, comment: defaultValue)
    }
    
}
