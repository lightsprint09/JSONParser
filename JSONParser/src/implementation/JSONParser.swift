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
        let object = try parseFoundationObject(data) as Container
        return try parseFunction(object, JSONKeyPath)
    }
    
    public func parseObject<TargetElement: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> TargetElement {
        return try parse(data, JSONKeyPath: JSONKeyPath, parseFunction: foundationParser.parse)
    }
    
    public func parseObject<TargetElement: DictionaryLiteralConvertible where TargetElement.Value: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> TargetElement {
       return try parse(data, JSONKeyPath: JSONKeyPath, parseFunction: foundationParser.parse)
    }
    
    public func parseObject<TargetElement: _ArrayType where TargetElement.Element: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> TargetElement {
        return try parse(data, JSONKeyPath: JSONKeyPath, parseFunction: foundationParser.parse)
    }
    
    //MARK: - private
    
    internal func parseFoundationObject<Container>(data: NSData) throws -> Container {
        guard let serializedObject = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves) as? Container else {
             throw NSError(domain: "Wrong type", code: 0, userInfo: ["data": data, "dataString": NSString(data: data, encoding: NSUTF8StringEncoding) ?? ""])
        }
        return serializedObject
    }
    
    
}