//
//  FoundationParser.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 11.04.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation

public struct FoundationParser {
    
    public init() {}
    
    public func parse<Result: JSONParsable>(container: Any, keyPath: String?) throws -> Result {
        func parseIt(typedContainer: Dictionary<String, Any>) throws -> Result {
            let trowableDict = ThrowableDictionary(dictionary: typedContainer)
            return try Result(JSON: trowableDict)
        }
        return try parse(container: container, keyPath: keyPath, parseFunction: parseIt)
    }
    
    public func parse<Result: ExpressibleByDictionaryLiteral>(container: Any, keyPath: String?) throws -> Result where Result.Value: JSONParsable {
        func parseIt(typedContainer: Dictionary<String, Dictionary<String, Any>>) throws -> Result {
            var result = Dictionary<String, Result.Value>()
            for (k, dict) in typedContainer.enumerated() {
                let trowableDict = ThrowableDictionary(dictionary: dict.value)
                let element = try Result.Value(JSON: trowableDict)
                result["\(k)"] = element

            }
            return result as! Result
        }
        
       return try parse(container: container, keyPath: keyPath, parseFunction: parseIt)
    }
    
    public func parse<T: Collection>(container: Any, keyPath: String?) throws -> T where T._Element: JSONParsable {
        func parseIt(typedContainer: Array<Dictionary<String, Any>>) throws -> T {
            let result: Array<T._Element> = try typedContainer.map{ jsonObj in
                let trowableDict = ThrowableDictionary(dictionary: jsonObj)
                return try T._Element(JSON: trowableDict)
            }
            return result as! T
        }
        
        return try parse(container: container, keyPath: keyPath, parseFunction: parseIt)
    }
    
    public func parseFoundationObject<T>(data: Any, keyPath: String?) throws -> T {
        if let rootDictionary = data as? [String: Any], let keyPath = keyPath , !keyPath.isEmpty {
            if let targetData = getValueForKeyPathFromDictionary(dictionary: rootDictionary, keyPath: keyPath), let typedTargetData = targetData as? T {
                return typedTargetData
            }else {
                throw ParseError.MissingKey(keyPath)
            }
        }
        
        if let targetData = data as? T {
            return targetData
        }
        throw ParseError.InvalidValue(keyPath ?? "Root keypath", String(describing: data.self))
    }
    
    public func getValueForKeyPathFromDictionary(dictionary: Dictionary<String, Any>, keyPath: String) -> Any? {
        let paths = keyPath.components(separatedBy: ".")
        var dict: Dictionary<String, Any>? = dictionary
        for(i, path) in paths.enumerated() {
            guard let value = dict?[path] else {
                return nil
            }
            guard let dictValue = value as? Dictionary<String, Any> else {
                if i == paths.count - 1 {
                     return value
                }
               continue
            }
            dict = dictValue
        }
        
        return dict as Any?
    }
    
    public func parse<Result, Container>(container: Any, keyPath: String?, parseFunction: (Container) throws -> (Result)) throws -> Result {
        let object = try parseFoundationObject(data: container, keyPath: keyPath) as Any
        if let primitive = object as? Result {
            return primitive
        }
        if let object = object as? Container {
            return try parseFunction(object)
        }
        throw ParseError.InvalidValue(keyPath ?? "Root keypath", String(describing: container.self))
    }
}
