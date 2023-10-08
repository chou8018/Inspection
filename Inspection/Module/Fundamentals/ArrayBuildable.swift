//
//  ArrayBuildable.swift
//  CarroConsumer
//
//  Created by Hein Htet on 16/7/20.
//  Copyright © 2020 Carro. All rights reserved.
//

import Foundation

public protocol ArrayBuildable {
    static func array(from jsonArray: [[String: Any]]) -> [Self]
}

public protocol InitFailable {
    init?(json: [String: Any])
}

extension ArrayBuildable where Self: InitFailable {
    
    public static func array(from jsonArray: [[String: Any]]) -> [Self] {
    
        var array = [Self]()
        
        for json in jsonArray {
            if let obj = Self.init(json: json) {
                array.append(obj)
            }
        }

        return array
        
    }
    
}

