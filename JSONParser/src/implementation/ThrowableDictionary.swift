//
//  ThrowableDictionary.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 25.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation

public struct ThrowableDictionary<Key: Hashable, Value> {
    let dictionary: Dictionary<Key, Value>
    
    public init(dictionary: Dictionary<Key, Value>) {
        self.dictionary = dictionary
    }
    
    public func valueFor<T>(key: Key) throws -> T {
        guard let value = dictionary[key] as? T else { throw NSError(domain: "Missing value for key: Key -> \(key)", code: 0, userInfo: nil) }
        
        return value
    }
}