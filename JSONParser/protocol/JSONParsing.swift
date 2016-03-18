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
     Parses NSData conatining a list of JSON types in an array of types conforming JSONParsable.
     
     - parameter data:        data wich contains JSON.
     - parameter JSONKeyPath: optional search path into JSON object for extracting result. Result must be an array.
     
     - throws: throws if JSON parsing failed.
     
     - returns: a list of objects parsed from JSON.
     */
    func parseList<T: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> Array<T>
    
    /**
     Parses NSData conatining a list of JSON types in an array of types conforming JSONParsable.
     
     - parameter data: data wich contains JSON.
     
     - throws: throws if JSON parsing failed.
     
     - returns: a list of objects parsed from JSON.
     */
    func parseList<T: JSONParsable>(data: NSData) throws -> Array<T>
    
    /**
     Parses NSData conatining a JSON object in an object conforming JSONParsable
     
     - parameter data:        data wich contains JSON object.
     - parameter JSONKeyPath: search path into JSON object for extracting result. Result must be an object.
     
     - throws: throws if JSON parsing failed.
     
     - returns: a object parsed from JSON.
     */
    func parseObject<T: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> T
    
    /**
     Parses NSData conatining a JSON object in an object conforming JSONParsable.
     
     - parameter data: data wich contains JSON object.
     
     - throws: throws if JSON parsing failed.
     
     - returns: a object parsed from JSON.
     */
    func parseObject<T: JSONParsable>(data: NSData) throws -> T
}

extension JSONParsing {
    
    public func parseObject<T: JSONParsable>(data: NSData) throws -> T {
        return try parseObject(data, JSONKeyPath: nil)
    }
    
    public func parseList<T: JSONParsable>(data: NSData) throws -> Array<T> {
        return try parseList(data, JSONKeyPath: nil)
    }
}

