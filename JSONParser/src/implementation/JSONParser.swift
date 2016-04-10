//
//  JSONParser.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 11.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation


public struct JSONParser: JSONParsing{
    
    public init() {}
    
    
    public func parseObject<T: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> T {
        let jsonValue = try parseFoundationObject(data, JSONKeyPath: JSONKeyPath) as AnyObject
        
        if let jsonPrimitive = jsonValue as? T {
            return jsonPrimitive
        }
        if let jsonObject = jsonValue as? Dictionary<String, AnyObject> {
            let trowableDict = ThrowableDictionary<String, AnyObject>(dictionary: jsonObject)
            return try T(JSON: trowableDict)
        }
        
        throw NSError(domain: "Worng type", code: 0, userInfo: nil)
    }
    
    public func parseObject<T: DictionaryLiteralConvertible where T.Value: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> T {
        let jsonList = try parseFoundationObject(data, JSONKeyPath: JSONKeyPath) as AnyObject
        
        if let primitives = jsonList as? T {
            return primitives
        }
        if let jsonObjects = jsonList as? Dictionary<String, Dictionary<String, AnyObject>> {
            var result = Dictionary<String, T.Value>()
            for (_, (key, dictionary)) in jsonObjects.enumerate() {
                let trowableDict = ThrowableDictionary<String, AnyObject>(dictionary: dictionary)
                let element = try T.Value(JSON: trowableDict)
                result[key] = element
            }
            
            return result as! T
        }
        
        throw NSError(domain: "Worng type", code: 0, userInfo: nil)
    }
    
    public func parseObject<T: _ArrayType where T.Element: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> T {
        let jsonList = try parseFoundationObject(data, JSONKeyPath: JSONKeyPath) as AnyObject
        
        if let primitives = jsonList as? T {
            return primitives
        }
        if let jsonObjects = jsonList as? Array<Dictionary<String, AnyObject>> {
            let result: Array<T.Element> = try jsonObjects.map{ jsonObj in
                    let trowableDict = ThrowableDictionary<String, AnyObject>(dictionary: jsonObj)
                    return try T.Element(JSON: trowableDict)
                }
            return result as! T
            }
        
        throw NSError(domain: "Worng type", code: 0, userInfo: nil)
    }
    
    //MARK: - private
    
    internal func parseFoundationObject<T>(data: NSData, JSONKeyPath: String?) throws -> T {
        let rootJSON = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves)
        if let rootDictionary = rootJSON as? NSDictionary, let JSONKeyPath = JSONKeyPath, let tagetJSON = rootDictionary.valueForKeyPath(JSONKeyPath) as? T where JSONKeyPath.characters.count > 0 {
            return tagetJSON
        }
        if let tagetJSON = rootJSON as? T {
            return tagetJSON
        }
        throw NSError(domain: "Worng type", code: 0, userInfo: nil)
    }
}