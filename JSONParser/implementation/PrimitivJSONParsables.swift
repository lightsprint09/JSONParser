//
//  PrimitivJSONParsables.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 14.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation

extension String: JSONParsable {
    public init(JSON: Dictionary<String, AnyObject>) {
        self = ""
    }
}

extension Double: JSONParsable {
    public init(JSON: Dictionary<String, AnyObject>) {
        self = 0
    }
}

extension Int: JSONParsable {
    public init(JSON: Dictionary<String, AnyObject>) {
        self = 0
    }
}

extension Bool: JSONParsable {
    public init(JSON: Dictionary<String, AnyObject>) {
        self = false
    }
}
