//
//  FoundationParser.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 11.04.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation

struct FoundationParser {
    
    init() {}
    
    func parse<Result: JSONParsable>(container: AnyObject, keyPath: String?) throws -> Result {
        func parseIt(typedContainer: Dictionary<String, AnyObject>) throws -> Result {
            let trowableDict = ThrowableDictionary(dictionary: typedContainer)
            return try Result(JSON: trowableDict)
        }
        return try parse(container, keyPath: keyPath, parseFunction: parseIt)
    }
    
    func parse<Result: DictionaryLiteralConvertible where Result.Value: JSONParsable>(container: AnyObject, keyPath: String?) throws -> Result {
        func parseIt(typedContainer: Dictionary<String, Dictionary<String, AnyObject>>) throws -> Result {
            var result = Dictionary<String, Result.Value>()
            for (_, (key, dictionary)) in typedContainer.enumerate() {
                let trowableDict = ThrowableDictionary(dictionary: dictionary)
                let element = try Result.Value(JSON: trowableDict)
                result[key] = element
            }
            return result as! Result
        }
        
       return try parse(container, keyPath: keyPath, parseFunction: parseIt)
    }
    
    func parse<T: _ArrayType where T.Element: JSONParsable>(container: AnyObject, keyPath: String?) throws -> T {
        func parseIt(typedContainer: Array<Dictionary<String, AnyObject>>) throws -> T {
            let result: Array<T.Element> = try typedContainer.map{ jsonObj in
                let trowableDict = ThrowableDictionary(dictionary: jsonObj)
                return try T.Element(JSON: trowableDict)
            }
            return result as! T
        }
        
        return try parse(container, keyPath: keyPath, parseFunction: parseIt)
    }
    
    func parseFoundationObject<T>(data: AnyObject, keyPath: String?) throws -> T {
        if let rootDictionary = data as? NSDictionary, let keyPath = keyPath where !keyPath.isEmpty {
            if let targetData = rootDictionary.valueForKeyPath(keyPath) {
                if let t = targetData as? T {
                    return t
                }
            }else {
                throw NSError(domain: "Wrong key: \(keyPath)", code: 0, userInfo: ["object": data])
            }
        }
        
        if let targetData = data as? T {
            return targetData
        }
        throw NSError(domain: "Worng type", code: 0, userInfo: ["object": data])
    }
    
    func parse<Result, Container>(container: AnyObject, keyPath: String?, parseFunction: (Container) throws -> (Result)) throws -> Result {
        let object = try parseFoundationObject(container, keyPath: keyPath) as AnyObject
        if let primitive = object as? Result {
            return primitive
        }
        if let object = object as? Container {
            return try parseFunction(object)
        }
        
        throw NSError(domain: "Worng type", code: 0, userInfo: nil)
    }
}