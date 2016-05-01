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
    
    public func parseObject<TargetElement: JSONParsable>(data: NSData, JSONKeyPath: String?, context: TargetElement.Context?) throws -> TargetElement {
        return try parse(data, JSONKeyPath: JSONKeyPath, context: context, parseFunction: foundationParser.parse)
    }
    
    public func parseObject<TargetElement: DictionaryLiteralConvertible where TargetElement.Value: JSONParsable>(data: NSData, JSONKeyPath: String?, context: TargetElement.Value.Context?) throws -> TargetElement {
       return try parse(data, JSONKeyPath: JSONKeyPath, context: context, parseFunction: foundationParser.parse)
    }
    
    public func parseObject<TargetElement: _ArrayType where TargetElement.Element: JSONParsable>(data: NSData, JSONKeyPath: String?, context: TargetElement.Element.Context?) throws -> TargetElement {
        return try parse(data, JSONKeyPath: JSONKeyPath, context: context, parseFunction: foundationParser.parse)
    }
    
    //MARK: - private
    
    /**
     Wrapps JSONSerialization into a generic function
     
     - parameter data: NSData which contains JSON
     
     - throws: throws when parsing fails, or parsed type if the wrong Container type
     
     - returns: the parse JSON as Container type
     */
    internal func parseFoundationObject<Container>(data: NSData) throws -> Container {
        guard let serializedObject = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? Container else {
             throw NSError(domain: "Wrong type", code: 0, userInfo: nil)
        }
        
        return serializedObject
    }
    
    internal func parse<TargetElement, Container, Context>(data: NSData, JSONKeyPath: String?, context: Context?, parseFunction: (Container, String?, Context?) throws -> TargetElement) throws -> TargetElement {
        let object = try parseFoundationObject(data) as Container
        
        return try parseFunction(object, JSONKeyPath, context)
    }
    
    
}