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
    
    func grCodeId(urlStr: String) -> String? {
        let component = urlStr.components(separatedBy: "=")
        if component.count > 1, let first = component.first, let id = component.last {
            if first == "inspectionandbookin://id" {
                return id
            }else{
                return nil
            }
        }
        return nil
    }
     
    var grCodeIDValue :  String? {
        if  let url = URL(string: self.trimWhiteSpace) {
            let urlStr = url.absoluteString
             print(urlStr)
            // Parse the custom URL as per your requirement.
            
            return grCodeId(urlStr: urlStr)

        }
        
        return nil
    }
    
    var grCodeIDValueNew :  String? {
        if self.contains("\n") , let firstStr = self.components(separatedBy: "\n").first {
            return grCodeId(urlStr: firstStr)
        } else {
            return grCodeId(urlStr: self)
        }
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
    
    func formateMileage() -> String {
        return conversionOfDigital(unit: "km.")
    }
    
    func conversionOfDigital(unit: String? = nil) -> String {
        
        if self.contains(",") {
            return self
        }
        
        let strings = components(separatedBy: ".")
        guard let _ = Float(self) else {
            return "0"
        }
        var value = strings.first ?? ""
        var float = ""
        if strings.count > 1 {
            float = strings.last ?? ""
        }
        
        if value.count <= 3 {
            if let unit = unit {
                return self + " " + unit
            }
            return self
        }
        
        let count = value.count/3
        let left = value.count%3
        
        let separate: Character = ","
        
        for index in 0..<count {
            if index == 0 && left != 0 {
                let index = value.index(value.startIndex, offsetBy: left)
                value.insert(separate, at: index)
            }else{
                let idx = left == 0 ? (index == 0 ? 1:index+1):index
                let index = value.index(value.startIndex, offsetBy: (idx)*3+index+left)
                value.insert(separate, at: index)
            }
        }
        if value.hasSuffix(String(separate)) {
            value.remove(at: value.index(value.endIndex, offsetBy: -1))
        }
        
        var returnValue = value
        if float.count > 0 {
            returnValue = value + "." + float
        }
        if let unit = unit {
            return returnValue + " " + unit
        }
        return returnValue
    }
}

extension String {
    
    static func localized(_ key: String, comment defaultValue: String = "") -> String {
        
        if let language = UserDefaults.getCurrentLanguage() {
            var languageCode = "en"
            if language == "EN" {
                languageCode = "en"
            } else {
                languageCode = "th"
            }
            return localizedWithLanguageCode(key: key, defaultValue: defaultValue, languageCode: languageCode)
        } else {
            if let languageCode = Locale.current.languageCode {
                return localizedWithLanguageCode(key: key, defaultValue: defaultValue, languageCode: languageCode)
            }
        }
        
        return NSLocalizedString(key, comment: defaultValue)
    }
    
    static func localizedWithLanguageCode(key: String ,defaultValue: String , languageCode: String) -> String {
        if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),let bundle = Bundle(path: path) {
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
