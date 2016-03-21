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
    
    init(JSON: Dictionary<String, AnyObject>) throws {
        guard let integerValue = JSON["integer"] as? Int, let doubleValue = JSON["double"] as? Double, let stringValue = JSON["string"] as? String, let boolValue = JSON["bool"] as? Bool else {
            throw NSError(domain: "Missing value", code: 0, userInfo: nil)
        }
        self.integer = integerValue
        self.double = doubleValue
        self.string = stringValue
        self.bool = boolValue
    }
}

func ==(lhs: IDTestObject, rhs: IDTestObject) -> Bool {
    return true
}

struct TestData {
    static let singleObject = "{\"integer\": 3, \"double\": 0.432, \"string\": \"string\", \"bool\": true}".dataUsingEncoding(NSUTF8StringEncoding)!
     static let singleInvalidObject = "{\"integer\": 3, \"string\": \"string\", \"bool\": true}".dataUsingEncoding(NSUTF8StringEncoding)!
    static let singleObjectKeyPath = "{\"keypath\": {\"integer\": 3, \"double\": 0.432, \"string\": \"string\", \"bool\": true}}".dataUsingEncoding(NSUTF8StringEncoding)!
    static let listKeypath = "{\"innerList\": [{\"integer\": 3, \"double\": 0.432, \"string\": \"string\", \"bool\": true}]}".dataUsingEncoding(NSUTF8StringEncoding)!
    static let list = "[{\"integer\": 3, \"double\": 0.432, \"string\": \"string\", \"bool\": true}]".dataUsingEncoding(NSUTF8StringEncoding)!
    
    static let singleObjectResult = try! IDTestObject(JSON: ["integer": 3, "double": 0.432, "string": "string", "bool": true])
}


