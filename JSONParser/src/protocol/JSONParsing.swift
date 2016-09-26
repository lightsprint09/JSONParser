//
//  JSONParsing.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 11.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation

public protocol JSONParsing {
    
    /**
     Parses Data conatining a JSON object in an object ArrayType with elements conforming to `JSONParsable`.
     
     - parameter data: data wich contains JSON.
     - parameter JSONKeyPath: search path into JSON object for extracting result. Result must be an Arrayliteral.
     
     - throws: throws if JSON parsing failed.
     
     - returns: a array of objects parsed from JSON.
     */
    func parseObject<T: Collection>(data: Data, JSONKeyPath: String?) throws -> T  where T._Element: JSONParsable
    
    /**
     Parses Data conatining a JSON object in an object ArrayType with elements conforming to `JSONParsable`.
     
     - parameter data: data wich contains JSON.
     
     - throws: throws if JSON parsing failed.
     
     - returns: a array of objects parsed from JSON.
     */
    func parseObject<T: Collection>(data: Data) throws -> T where T._Element: JSONParsable
    
    /**
     Parses `Data` conatining a JSON object in an object `DictionaryLiteralConvertible` with values conforming to `JSONParsable`
     
     - parameter data: data wich contains JSON.
     - parameter JSONKeyPath: search path into JSON object for extracting result. Result must be an Arrayliteral.
     
     - throws: throws if JSON parsing failed.
     
     - returns: a dictionary of objects parsed from JSON.
     */
    func parseObject<T: ExpressibleByDictionaryLiteral>(data: Data, JSONKeyPath: String?) throws -> T where T.Value: JSONParsable
    
    /**
     Parses `Data` conatining a JSON object in an object `DictionaryLiteralConvertible` with values conforming to `JSONParsable`.
     
     - parameter data: data wich contains JSON.
     
     - throws: throws if JSON parsing failed.
     
     - returns: a dictionary of objects parsed from JSON.
     */
    func parseObject<T: ExpressibleByDictionaryLiteral>(data: Data) throws -> T where T.Value: JSONParsable
    
    /**
     Parses `Data` conatining a JSON object in an object conforming `JSONParsable`.
     
     - parameter data:        data wich contains JSON object.
     - parameter JSONKeyPath: search path into JSON object for extracting result. Result must be an object.
     
     - throws: throws if JSON parsing failed.
     
     - returns: a object parsed from JSON.
     */
    func parseObject<T: JSONParsable>(data: Data, JSONKeyPath: String?) throws -> T
    
    /**
     Parses `Data` conatining a JSON object in an object conforming `JSONParsable`.
     
     - parameter data: data wich contains JSON object.
     
     - throws: throws if JSON parsing failed.
     
     - returns: a object parsed from JSON.
     */
    func parseObject<T: JSONParsable>(data: Data) throws -> T
    
}

public extension JSONParsing {
    
    public func parseObject<T: JSONParsable>(data: Data) throws -> T {
        return try parseObject(data: data, JSONKeyPath: nil)
    }
    
    public func parseObject<T: Collection>(data: Data) throws -> T where T._Element: JSONParsable {
        return try parseObject(data: data, JSONKeyPath: nil)
    }
    
    public func parseObject<T: ExpressibleByDictionaryLiteral>(data: Data) throws -> T where T.Value: JSONParsable {
        return try parseObject(data: data, JSONKeyPath: nil)
    }
}

