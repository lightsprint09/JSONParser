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
        
        return try parser.parse(container: dictionary as AnyObject, keyPath: keyPath)
    }
    
    public func valueFor<T: Collection>(keyPath: String) throws -> T where T._Element: JSONParsable {
        return try parser.parse(container: dictionary as AnyObject, keyPath: keyPath)
    }
    
    public func valueFor<T: ExpressibleByDictionaryLiteral>(keyPath: String) throws -> T where T.Value: JSONParsable {
        return try parser.parse(container: dictionary as AnyObject, keyPath: keyPath)
    }
}
