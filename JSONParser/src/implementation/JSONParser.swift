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
    
    internal func parse<TargetElement, Container>(data: Data, JSONKeyPath: String?, parseFunction: (Container, String?) throws -> (TargetElement)) throws -> TargetElement {
        let object = try parseFoundationObject(data: data) as Container
        return try parseFunction(object, JSONKeyPath)
    }
    
    public func parseObject<TargetElement: JSONParsable>(data: Data, JSONKeyPath: String?) throws -> TargetElement {
        return try parse(data: data, JSONKeyPath: JSONKeyPath, parseFunction: foundationParser.parse)
    }
    
    public func parseObject<TargetElement: ExpressibleByDictionaryLiteral>(data: Data, JSONKeyPath: String?) throws -> TargetElement where TargetElement.Value: JSONParsable {
       return try parse(data: data, JSONKeyPath: JSONKeyPath, parseFunction: foundationParser.parse)
    }
    
    public func parseObject<TargetElement: RangeReplaceableCollection>(data: Data, JSONKeyPath: String?) throws -> TargetElement where TargetElement._Element: JSONParsable {
        return try parse(data: data, JSONKeyPath: JSONKeyPath, parseFunction: foundationParser.parse)
    }
    
    //MARK: - private
    
    internal func parseFoundationObject<Container>(data: Data) throws -> Container {
        guard let serializedObject = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? Container else {
             throw NSError(domain: "Wrong type", code: 0, userInfo: ["data": data, "dataString": NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? ""])
        }
        return serializedObject
    }
    
    
}
