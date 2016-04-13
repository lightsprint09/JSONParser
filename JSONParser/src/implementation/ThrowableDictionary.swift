//
//  ThrowableDictionary.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 25.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation

public struct ThrowableDictionary {
    public let dictionary: Dictionary<String, AnyObject>
    let parser = FoundationParser()
    
    public init(dictionary: Dictionary<String, AnyObject>) {
        self.dictionary = dictionary
    }
    
    public func valueFor<T: JSONParsable>(keyPath: String? = nil) throws -> T {
        return try parser.parse(dictionary, keyPath: keyPath)
    }
    
    public func valueFor<T: _ArrayType where T.Element: JSONParsable>(keyPath: String) throws -> T {
        return try parser.parse(dictionary, keyPath: keyPath)
    }
    
    public func valueFor<T: DictionaryLiteralConvertible where T.Value: JSONParsable>(keyPath: String) throws -> T {
        return try parser.parse(dictionary, keyPath: keyPath)
    }
}