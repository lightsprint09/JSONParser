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
    
    init(JSON: ThrowableDictionary<NoContext>) throws {
        self.integer = try JSON.valueFor("integer")
        self.double = try JSON.valueFor("double")
        self.string = try JSON.valueFor("string")
        self.bool = try JSON.valueFor("bool")
    }
}

func ==(lhs: IDTestObject, rhs: IDTestObject) -> Bool {
    return lhs.integer == rhs.integer && lhs.double == rhs.double && lhs.string == rhs.string && lhs.bool == rhs.bool
}

struct TestData {
    static let singleObject = "{\"integer\": 3, \"double\": 0.432, \"string\": \"string\", \"bool\": true}".dataUsingEncoding(NSUTF8StringEncoding)!
     static let singleInvalidObject = "{\"integer\": 3, \"string\": \"string\", \"bool\": true}".dataUsingEncoding(NSUTF8StringEncoding)!
    static let singleInvalidJSON = "\"integer\": 3, \"string\": \"string\", \"bool\": true}".dataUsingEncoding(NSUTF8StringEncoding)!
    static let singleObjectKeyPath = "{\"keypath\": {\"integer\": 3, \"double\": 0.432, \"string\": \"string\", \"bool\": true}}".dataUsingEncoding(NSUTF8StringEncoding)!
    static let listKeypath = "{\"innerList\": [{\"integer\": 3, \"double\": 0.432, \"string\": \"string\", \"bool\": true}]}".dataUsingEncoding(NSUTF8StringEncoding)!
    static let list = "[{\"integer\": 3, \"double\": 0.432, \"string\": \"string\", \"bool\": true}]".dataUsingEncoding(NSUTF8StringEncoding)!
    
    static let singleObjectResult = try! IDTestObject(JSON: ThrowableDictionary(dictionary: ["integer": 3, "double": 0.432, "string": "string", "bool": true]))
}


