//
//  JSONUtils.swift
//  Core
//
//  Created by Thet Htun on 4/10/22.
//

import Foundation

public class JSONUtils {
    
    public static let shared = JSONUtils()
    
    private init() { }
    
    public func loadDataFromJSON(fileName: String, bundle: Bundle = .main) throws -> Data {
        try Data.fromJSON(fileName: fileName, bundle: bundle)
    }

    public func getInitFailableResponseFromJson<T: InitFailable>(fileName: String, bundle: Bundle = .main) -> T {
        do {
            let data = try Data.fromJSON(fileName: fileName, bundle: bundle)
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                return T(json: json)!
            }
        } catch {
            print(error.localizedDescription)
        }

        fatalError("JSON parsing failed.")
    }

    public func getCodableResponseFromJson<T: Codable>(fileName: String, bundle: Bundle = .main) -> T {
        do {
            let data = try loadDataFromJSON(fileName: fileName, bundle: bundle)
            return try JSONDecoder().decode(T.self, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch (let error) {
            // MARK: - Please do not delete the below print for debugging
            print(error.localizedDescription)
        }

        fatalError("JSON parsing in testing environment shouldn't fail.")
    }
}
