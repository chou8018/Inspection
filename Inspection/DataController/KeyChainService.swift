//
//  KeyChainService.swift
//  Inspection
//
//  Created by Thanawat prathumset on 6/5/2564 BE.
//

import Foundation
import KeychainAccess

class KeyChainService {

    let keychain = Keychain(service: "com.motto.auction.inspection")
    static let shared = KeyChainService()
    
    func clearData(){
        keychain["firstname"] = nil
        keychain["lastname"] = nil
        keychain["email"] = nil
    }
    
    //MARK: first name
    func setFirstName(value:String?) {
        keychain["firstname"] = value
    }
    func getFirstName() -> String? {
        return try? keychain.getString("firstname")
    }
    
    //MARK: last name
    func setLastName(value:String?) {
        keychain["lastname"] = value
    }
    func getLastName() -> String? {
        return try? keychain.getString("lastname")
    }
    
    //MARK: email
    func setEmail(value:String?) {
        keychain["email"] = value
    }
    func getEmail() -> String? {
        return try? keychain.getString("email")
    }

}
