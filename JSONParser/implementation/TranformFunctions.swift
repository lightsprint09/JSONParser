//
//  TranformFunctions.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 18.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation


extension Dictionary where Key: StringLiteralConvertible {
    
    public func transformToObject<T: JSONParsable>() -> T? {
        return transformToObject(keyPath: nil)
    }
    
    public func transformToObject<T: JSONParsable>(keyPath keyPath: String?) -> T? {
        guard let JSON = transformJSON(keyPath: keyPath) as Dictionary<String, AnyObject>? else { return nil }
        return T(JSON: JSON)
    }
    
    public func transformToList<T: JSONParsable>(keyPath keyPath: String) -> Array<T>? {
        guard let JSON = transformJSON(keyPath: keyPath) as Array<Dictionary<String, AnyObject>>? else { return nil }
        
        return JSON.map{ jsonObj in
            return T(JSON: jsonObj)
        }
    }
    //TODO: Find less hacky solution
    private func transformJSON<T>(keyPath keyPath: String?) -> T? {
        guard let dictionaryValue = self as? NSDictionary else { return nil}
        
        if let keyPath = keyPath, let JSON = dictionaryValue[keyPath] as? T {
            return JSON
        }
        return dictionaryValue as? T
    }
}

