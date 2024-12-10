//
//  Userdefault+Helper.swift
//  dealers
//
//  Created by 付耀辉 on 2021/6/29.
//  Copyright © 2021 Trusty Cars. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static let languageKey = "languageKey"
    
    static func getCurrentLanguage() -> String? {
        return get(key: languageKey) as? String
    }
    
    static func saveCurrentLanguage(value: String) {
        save(key: languageKey, value: value)
    }
    
    static func removeCurrentLanguage() {
        remove(key: languageKey)
    }
    
    static func save(key:String, value:Any) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(value, forKey: key)
        userDefault.synchronize()
    }

    static func remove(key:String) {
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: key)
        userDefault.synchronize()
    }

    static func get(key:String) -> Any? {
        let userDefault = UserDefaults.standard
        return userDefault.value(forKey: key)
    }
}

