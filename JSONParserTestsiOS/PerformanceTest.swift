//
//  PerformanceTest.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 29.04.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import XCTest
@testable import JSONParser

struct Struct {
    let string: String
    let int: Int
    let double: Double
    let float: Float
    let bool: Bool
    let array: [AnyObject]
    let dictionary: [String: AnyObject]
    let optionalFloat: Float?
    let optionalString: String?
    let optionalInt: Int?
    let optionalDouble: Double?
    let optionalBool: Bool?
    let optionalArray: [AnyObject]?
    let optionalDictionary: [String: AnyObject]?
}

extension Struct: JSONParsable {
    init(JSON: ThrowableDictionary<NoContext>) throws  {
        string = try JSON.valueFor("string")
        int = try JSON.valueFor("int")
        double = try JSON.valueFor("double")
        float = try JSON.valueFor("float")
        bool = try JSON.valueFor("bool")
        array = try JSON.valueFor("array")
        dictionary = try JSON.valueFor("dictionary")
        optionalString = try? JSON.valueFor("string")
        optionalInt = try? JSON.valueFor("int")
        optionalDouble = try? JSON.valueFor("double")
        optionalFloat = try? JSON.valueFor("float")
        optionalBool = try? JSON.valueFor("bool")
        optionalArray = try? JSON.valueFor("array")
        optionalDictionary = try? JSON.valueFor("dictionary")
    }
}

class PerformanceTest: XCTestCase {
    let object: AnyObject = [
        "string": "string",
        "int": 42,
        "double": 42,
        "float": 42,
        "bool": true,
        "array": ["one", "two", "three"],
        "dictionary": ["string": "string", "int": 42]
    ]

    func testJSONParser_100() {
        let dictionary = object as! Dictionary<String, AnyObject>
        measureBlock {
            for _ in 0..<100 {
                let dict = ThrowableDictionary<NoContext>(dictionary: dictionary)
                let _: Struct = try! dict.valueFor()
            }
        }
    }
    
    func testJSONParser_1000() {
        let dictionary = object as! Dictionary<String, AnyObject>
        measureBlock {
            for _ in 0..<1000 {
                let dict = ThrowableDictionary<NoContext>(dictionary: dictionary)
                let _: Struct = try! dict.valueFor()
            }
        }
    }
    
    func testJSONParser_10000() {
        let dictionary = object as! Dictionary<String, AnyObject>
        measureBlock {
            for _ in 0..<10000 {
                let dict = ThrowableDictionary<NoContext>(dictionary: dictionary)
                let _: Struct = try! dict.valueFor()
            }
        }
    }

}
