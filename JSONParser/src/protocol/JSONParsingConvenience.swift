//
//  JSONContextParsing.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 30.04.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation

public protocol JSONParsingConvenience {
    func parseObject<T: _ArrayType where T.Element: JSONParsable>(data: NSData) throws -> T
    
    func parseObject<T: _ArrayType where T.Element: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> T
    
    func parseObject<T: _ArrayType where T.Element: JSONParsable>(data: NSData, context: T.Element.Context?) throws -> T
    
    
    func parseObject<T: DictionaryLiteralConvertible where T.Value: JSONParsable>(data: NSData) throws -> T
    
    func parseObject<T: DictionaryLiteralConvertible where T.Value: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> T
    
    func parseObject<T: DictionaryLiteralConvertible where T.Value: JSONParsable>(data: NSData, context: T.Value.Context?) throws -> T
    
    func parseObject<T: JSONParsable>(data: NSData) throws -> T
    
    func parseObject<T: JSONParsable>(data: NSData, JSONKeyPath: String?) throws -> T
    
    func parseObject<T: JSONParsable>(data: NSData, context: T.Context?) throws -> T
}