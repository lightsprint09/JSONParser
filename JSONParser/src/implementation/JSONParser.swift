//
//  JSONParser.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 11.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation


public struct JSONParser: JSONParsing{
    let foundationParser = FoundationParser()
    
    public init() {}
    
    internal func parse<TargetElement, Container>(data: NSData, JSONKeyPath: String?, parseFunction: (Container, String?) throws -> (TargetElement)) throws -> TargetElement {
        let object = try parseFoundationObject(data, JSONKeyPath: JSONKeyPath) as AnyObject
        if let primitive = object as? TargetElement {
            return primitive
        }
        if let object = object as? Container {
            return try parseFunction(object, JSONKeyPath)
        }
        
        throw NSError(domain: "Worng type", code: 0, userInfo: nil)
    }
    
    public func parseObject<T: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> T {
        return try parse(data, JSONKeyPath: JSONKeyPath, parseFunction: foundationParser.parse)
    }
    
    public func parseObject<T: DictionaryLiteralConvertible where T.Value: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> T {
       return try parse(data, JSONKeyPath: JSONKeyPath, parseFunction: foundationParser.parse)
    }
    
    public func parseObject<T: _ArrayType where T.Element: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> T {
        return try parse(data, JSONKeyPath: JSONKeyPath, parseFunction: foundationParser.parse)
    }
    
    //MARK: - private
    
    internal func parseFoundationObject<T>(data: NSData, JSONKeyPath: String?) throws -> T {
        return try NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves) as! T
    }
    
    
}