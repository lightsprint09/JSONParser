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
     Parses NSData conatining a list of JSON objects in a array of objects conforming JSONParsable
     
     - parameter data:        data wich contains json. Toplevel JSON must be an object not an array
     - parameter JSONKeyPath: search path into JSON object for extracting result
     
     - throws: throws if JSON parsing failed
     
     - returns: a list of objects parsed from JSON
     */
    func parseList<T: JSONParsable>(data: NSData, JSONKeyPath: String) throws -> Array<T>
    
    /**
     Parses NSData conatining a JSON object in an object conforming JSONParsable
     
     - parameter data:        data wich contains json. Toplevel JSON must be an object not an array
     - parameter JSONKeyPath: search path into JSON object for extracting result
     
     - throws: throws if JSON parsing failed
     
     - returns: a object parsed from JSON
     */
    func parseObject<T: JSONParsable>(data: NSData, JSONKeyPath: String) throws -> T
    
    /**
     Parses NSData conatining a JSON object to an object of a Foundation Collection
     
     - parameter data:        data wich contains json. Toplevel JSON must be an object not an array
     - parameter JSONKeyPath: search path into JSON object for extracting result
     
     - throws: throws if JSON parsing failed
     
     - returns: a colection object parsed from JSON
     */
    func parseRawObject<T: CollectionType>(data: NSData, JSONKeyPath: String ) throws -> T
}