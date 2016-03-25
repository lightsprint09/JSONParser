//
//  TranformFunctions.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 18.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation


public extension ThrowableDictionary where Key: StringLiteralConvertible {
    
    public func transformToObject<T: JSONParsable>() -> T? {
        return transformToObject(keyPath: nil)
    }
    
    public func transformToObject<T: JSONParsable>(keyPath keyPath: String?) -> T? {
        guard let JSON = transformJSON(keyPath: keyPath) as AnyObject? else { return nil }
        if let result = JSON as? T {
            return result
        }
        guard let dictJSON = JSON as? Dictionary<String, AnyObject> else { return nil }
        let trowableDict = ThrowableDictionary<String, AnyObject>(dictionary: dictJSON)
        return try? T(JSON: trowableDict)
        
    }
    
    public func transformToList<T: JSONParsable>(keyPath keyPath: String) -> Array<T>? {
        guard let JSON = transformJSON(keyPath: keyPath) as AnyObject? else { return nil }
        if let result = JSON as? Array<T> {
            return result
        }
        guard let arrayJSON = JSON as? Array<Dictionary<String, AnyObject>> else { return nil }
        
        return try? arrayJSON.map{ dict in
            let trowableDict = ThrowableDictionary<String, AnyObject>(dictionary: dict)
            return try T(JSON: trowableDict) }
    }
    //TODO: Find less hacky solution
    private func transformJSON<T>(keyPath keyPath: String?) -> T? {
        guard let dictionaryValue = self.dictionary as? NSDictionary else { return nil}
        if let keyPath = keyPath, let JSON = dictionaryValue.valueForKeyPath(keyPath) as? T {
            return JSON
        }
        return dictionaryValue as? T
    }
}


