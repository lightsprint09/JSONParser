//
//  JSONParserInjectionTest.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 30.04.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import XCTest
@testable import JSONParser

class JSONParserInjectionTest: XCTestCase {
    let parser = JSONParser()
    
        
    func testObject() {
        do {
            let context = "context"
            let obj: IDTestInjectObject = try parser.parseObject(TestData.singleObject, context: context)
            XCTAssertEqual(obj.context, context)
        }catch {
            XCTFail()
        }
    }
    
    func testNilObject() {
        do {
            let context: String? = nil
            let obj: IDTestInjectObject = try parser.parseObject(TestData.singleObject, context: context)
            XCTAssertEqual(obj.context, context)
        }catch {
            XCTFail()
        }
    }
    
    func testKeyPathObject() {
        do {
            let context = "context"
            let obj: IDTestInjectObject = try parser.parseObject(TestData.singleObjectKeyPath, JSONKeyPath: "keypath", context: context)
            XCTAssertEqual(obj.context, context)
        }catch {
            XCTFail()
        }
    }
    
    
    func testDictionaryTypeWithObject() {
        let jsonData = "{\"object\": {\"integer\": 3, \"double\": 0.432, \"string\": \"string\", \"bool\": true}}".dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let context = "context"
            let dictionary: Dictionary<String, IDTestInjectObject> = try parser.parseObject(jsonData, context: context)
            XCTAssertEqual(dictionary["object"]!.context, context)
        }catch {
            XCTFail()
        }
    }


}
