//
//  PrimitivJSONParsables.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 14.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation

extension String: JSONParsable {
    public init(JSON: ThrowableDictionary<NoContext>) {
        self = ""
        fatalError("Should not instatiate")
    }
}

extension Double: JSONParsable {
    public init(JSON: ThrowableDictionary<NoContext>) {
        self = 0
        fatalError("Should not instatiate")
    }
}

extension Int: JSONParsable {
    public init(JSON: ThrowableDictionary<NoContext>) {
        self = 0
        fatalError("Should not instatiate")
    }
}

extension Float: JSONParsable {
    public init(JSON: ThrowableDictionary<NoContext>) {
        self = 0
        fatalError("Should not instatiate")
    }
}

extension Bool: JSONParsable {
    public init(JSON: ThrowableDictionary<NoContext>) {
        self = false
        fatalError("Should not instatiate")
    }
}

