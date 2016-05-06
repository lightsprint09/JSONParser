//
//  JSONContextParsing.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 30.04.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation

public protocol JSONParsingConvenience {
    /**
     Parses NSData conatining a JSON object in an object ArrayType with elements conforming to `JSONParsable`.
     
     - parameter data: data wich contains JSON.
     - throws: throws if JSON parsing failed.
     
     - returns: a array of objects parsed from JSON.
     */
    func parseObject<T: _ArrayType where T.Element: JSONParsable>(data: NSData) throws -> T
    
    /**
     Parses NSData conatining a JSON object in an object ArrayType with elements conforming to `JSONParsable`.
     
     - parameter data: data wich contains JSON.
     - parameter JSONKeyPath: search path into JSON object for extracting result. Result must be an Arrayliteral.
     
     - throws: throws if JSON parsing failed.
     
     - returns: a array of objects parsed from JSON.
     */
    func parseObject<T: _ArrayType where T.Element: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> T
    
    /**
     Parses NSData conatining a JSON object in an object ArrayType with elements conforming to `JSONParsable`.
     
     - parameter data: data wich contains JSON.
     - parameter context: Inject a context into the passable. E.g. be database access
     
     - throws: throws if JSON parsing failed.
     
     - returns: a array of objects parsed from JSON.
     */
    func parseObject<T: _ArrayType where T.Element: JSONParsable>(data: NSData, context: T.Element.Context?) throws -> T
    
    /**
     Parses `NSData` conatining a JSON object in an object `DictionaryLiteralConvertible` with values conforming to `JSONParsable`
     
     - parameter data: data wich contains JSON.
     
     - throws: throws if JSON parsing failed.
     
     - returns: a dictionary of objects parsed from JSON.
     */
    func parseObject<T: DictionaryLiteralConvertible where T.Value: JSONParsable>(data: NSData) throws -> T
    
    /**
     Parses `NSData` conatining a JSON object in an object `DictionaryLiteralConvertible` with values conforming to `JSONParsable`
     
     - parameter data: data wich contains JSON.
     - parameter JSONKeyPath: search path into JSON object for extracting result. Result must be an Arrayliteral.
     
     - throws: throws if JSON parsing failed.
     
     - returns: a dictionary of objects parsed from JSON.
     */
    func parseObject<T: DictionaryLiteralConvertible where T.Value: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> T
    
    /**
     Parses `NSData` conatining a JSON object in an object `DictionaryLiteralConvertible` with values conforming to `JSONParsable`
     
     - parameter data: data wich contains JSON.
     - parameter context: Inject a context into the passable. E.g. be database access
     
     - throws: throws if JSON parsing failed.
     
     - returns: a dictionary of objects parsed from JSON.
     */
    func parseObject<T: DictionaryLiteralConvertible where T.Value: JSONParsable>(data: NSData, context: T.Value.Context?) throws -> T
    
    /**
     Parses `NSData` conatining a JSON object in an object conforming `JSONParsable`.
     
     - parameter data:        data wich contains JSON object.
     
     - throws: throws if JSON parsing failed.
     
     - returns: a object parsed from JSON.
     */
    func parseObject<T: JSONParsable>(data: NSData) throws -> T
    
    /**
     Parses `NSData` conatining a JSON object in an object conforming `JSONParsable`.
     
     - parameter data:        data wich contains JSON object.
     
     - throws: throws if JSON parsing failed.
     
     - returns: a object parsed from JSON.
     */
    func parseObject<T: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> T
    
    /**
     Parses `NSData` conatining a JSON object in an object conforming `JSONParsable`.
     
     - parameter data:        data wich contains JSON object.
     
     - throws: throws if JSON parsing failed.
     
     - returns: a object parsed from JSON.
     */
    func parseObject<T: JSONParsable>(data: NSData, context: T.Context?) throws -> T
}