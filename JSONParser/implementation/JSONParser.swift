//
//  JSONParser.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 11.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation

public struct JSONParser: JSONParsing{
    
    func parseRawObject<T>(data: NSData, JSONKeyPath: String?) throws -> T {
        let rootJSON = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves)
        if let rootDictionary = rootJSON as? NSDictionary, let JSONKeyPath = JSONKeyPath, let tagetJSON = rootDictionary.valueForKeyPath(JSONKeyPath) as? T where JSONKeyPath.characters.count > 0 {
            return tagetJSON
        }
        if let tagetJSON = rootJSON as? T {
            return tagetJSON
        }
        throw NSError(domain: "Worng type", code: 0, userInfo: nil)
    }
    
    public func parseList<T: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> Array<T> {
        let jsonList = try parseRawObject(data, JSONKeyPath: JSONKeyPath) as AnyObject
        
        if let primitives = jsonList as? Array<T> {
            return primitives
        }
        if let jsonObjects = jsonList as? Array<Dictionary<String, AnyObject>> {
            return jsonObjects.map{ jsonObj in
                return T(JSON: jsonObj)
            }
        }
        throw NSError(domain: "Worng type", code: 0, userInfo: nil)
    }
    
    public func parseObject<T: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> T {
        let jsonValue = try parseRawObject(data, JSONKeyPath: JSONKeyPath) as AnyObject
        
        if let jsonPrimitive = jsonValue as? T {
            return jsonPrimitive
        }
        if let jsonObject = jsonValue as? Dictionary<String, AnyObject> {
            return T(JSON: jsonObject)
        }
        
        throw NSError(domain: "Worng type", code: 0, userInfo: nil)
    }
}