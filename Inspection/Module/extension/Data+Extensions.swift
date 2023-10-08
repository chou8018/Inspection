//
//  Data+Extensions.swift
//  Core
//
//  Created by Thet Htun on 4/10/22.
//

import Foundation

public enum JSONLoadingError: Error {
    case fileNotFound(_ message: String)
}

extension Data {
    public static func fromJSON(
        fileName: String,
        file: StaticString = #file,
        line: UInt = #line,
        bundle: Bundle = Bundle.main
    ) throws -> Data {
        let url = try bundle.url(forResource: fileName, withExtension: "json")
        guard let url = url else {
            throw JSONLoadingError.fileNotFound("Unable to find \(fileName).json. Did you add it to the tests?")
        }
        
        return try Data(contentsOf: url)
    }
}
