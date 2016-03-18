//
//  TestHelpers.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 13.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation
@testable import JSONParser


struct IDTestObject:  JSONParsable, Equatable{
    let integer: Int
    let double: Double
    let string: String
    let bool: Bool
    
    init(JSON: Dictionary<String, AnyObject>) {
        self.integer = JSON["integer"] as! Int
        self.double = JSON["double"] as! Double
        self.string = JSON["string"] as! String
        self.bool = JSON["bool"] as! Bool
    }
}

func ==(lhs: IDTestObject, rhs: IDTestObject) -> Bool {
    return true
}

struct TestData {
    static let singleObject = "{\"integer\": 3, \"double\": 0.432, \"string\": \"string\", \"bool\": true}".dataUsingEncoding(NSUTF8StringEncoding)!
    static let singleObjectKeyPath = "{\"keypath\": {\"integer\": 3, \"double\": 0.432, \"string\": \"string\", \"bool\": true}}".dataUsingEncoding(NSUTF8StringEncoding)!
    static let listKeypath = "{\"innerList\": [{\"integer\": 3, \"double\": 0.432, \"string\": \"string\", \"bool\": true}]}".dataUsingEncoding(NSUTF8StringEncoding)!
    static let list = "[{\"integer\": 3, \"double\": 0.432, \"string\": \"string\", \"bool\": true}]".dataUsingEncoding(NSUTF8StringEncoding)!
    
    static let singleObjectResult = IDTestObject(JSON: ["integer": 3, "double": 0.432, "string": "string", "bool": true])
}


