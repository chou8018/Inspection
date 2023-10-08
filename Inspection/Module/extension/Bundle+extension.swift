//
//  Bundle+extension.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 18/6/2564 BE.
//

import Foundation
extension Bundle {

    var appName: String {
        return infoDictionary?["CFBundleName"] as! String
    }

    var bundleId: String {
        return bundleIdentifier!
    }

    var versionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }

    var buildNumber: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }

    public static func getBundle(for object: AnyObject) -> Bundle {
        return Bundle(for: type(of: object))
    }
}
