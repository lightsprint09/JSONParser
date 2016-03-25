//
//  TranformFunctions.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 18.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation


public extension ThrowableDictionary where Key: StringLiteralConvertible {
    
    public func transformToObject<T: JSONParsable>() throws -> T {
        return try transformToObject(keyPath: nil)
    }
    
    public func transformToObject<T: JSONParsable>(keyPath keyPath: String?) throws -> T {
        let JSON: AnyObject = try transformJSON(keyPath: keyPath)
        if let result = JSON as? T {
            return result
        }
        guard let dictJSON = JSON as? Dictionary<String, AnyObject> else {
            throw createError(keyPath)
        }
        let trowableDict = ThrowableDictionary<String, AnyObject>(dictionary: dictJSON)
        return try T(JSON: trowableDict)
        
    }
    
    public func transformToList<T: JSONParsable>(keyPath keyPath: String) throws -> Array<T> {
        guard let JSON = try transformJSON(keyPath: keyPath) as AnyObject? else {
            throw createError(keyPath)
        }
        if let result = JSON as? Array<T> {
            return result
        }
        guard let arrayJSON = JSON as? Array<Dictionary<String, AnyObject>> else {
            throw createError(keyPath)
        }
        
        return try arrayJSON.map{ dict in
            let trowableDict = ThrowableDictionary<String, AnyObject>(dictionary: dict)
            return try T(JSON: trowableDict) }
    }
    
    private func createError(keyPath: String?) -> NSError {
       return NSError(domain: "Tranformation failed for keypath: keypath -> \(keyPath)", code: 0, userInfo: ["data": self.castToNSDictionary()!])
    }
    
    private func castToNSDictionary() -> NSDictionary? {
        return self.dictionary as? NSDictionary
    }
    //TODO: Find less hacky solution
    private func transformJSON<T>(keyPath keyPath: String?) throws -> T {
        guard let dictionaryValue = self.castToNSDictionary() else {
            throw createError(keyPath)
        }
        if let keyPath = keyPath, let JSON = dictionaryValue.valueForKeyPath(keyPath) as? T {
            return JSON
        }
        if let _ = keyPath {
            throw createError(keyPath)
        }
        guard let dictionaryValueT = dictionaryValue as? T else {
            throw createError(keyPath)
        }
        return dictionaryValueT
    }
}


