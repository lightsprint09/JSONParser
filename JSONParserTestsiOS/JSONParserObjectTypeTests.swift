//
//  JSONParserTests.swift
//  JSONParserTests
//
//  Created by Lukas Schmidt on 11.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import XCTest
@testable import JSONParser

class JSONParserObjectTypeTests: XCTestCase {
    let parser = JSONParser()
    
    func testObject() {
        do {
            let obj: IDTestObject = try parser.parseObject(TestData.singleObject)
            XCTAssertEqual(obj, TestData.singleObjectResult)
        }catch {
            XCTFail()
        }
    }
    
    func testInvalidObject() {
        do {
            let _: IDTestObject = try parser.parseObject(TestData.singleInvalidObject)
            XCTFail()
        }catch let err as NSError{
            XCTAssertNotNil(err)
            print(err)
        }
    }
    
    func testInvalidJSON() {
        do {
            let _: IDTestObject = try parser.parseObject(TestData.singleInvalidJSON)
            XCTFail()
        }catch let err as NSError{
            XCTAssertNotNil(err)
        }
    }
    
    func testKeyPathObject() {
        do {
            let obj: IDTestObject = try parser.parseObject(TestData.singleObjectKeyPath, JSONKeyPath: "keypath")
            XCTAssertEqual(obj, TestData.singleObjectResult)
        }catch {
            XCTFail()
        }
    }
    
    func testPrimitiveValue() {
        let jsonData = "{\"id\": 3}".dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let double: Double = try parser.parseObject(jsonData, JSONKeyPath: "id")
            XCTAssertEqual(double, 3)
        }catch {
            XCTFail()
        }
    }
    
    func testPrimitiveKeypathValue() {
        let jsonData = "{\"keypath\": {\"id\": 7}}".dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let double: Double = try parser.parseObject(jsonData, JSONKeyPath: "keypath.id")
            XCTAssertEqual(double, 7)
        }catch {
            XCTFail()
        }
    }
    
    func testDicationaryType() {
        let jsonData = "{\"id\": 7}".dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let dictionary: Dictionary<String, Int> = try parser.parseObject(jsonData)
             XCTAssertEqual(dictionary["id"], 7)
        }catch {
            XCTFail()
        }
    }
    
    func testDicationaryKeypath() {
        let jsonData = "{\"keypath\": {\"id\": 7}}".dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let dictionary: Dictionary<String, Int> = try parser.parseObject(jsonData, JSONKeyPath: "keypath")
            XCTAssertEqual(dictionary["id"], 7)
        }catch {
            XCTFail()
        }
    }
    
    func testDictionaryTypeWithObject() {
        let jsonData = "{\"object\": {\"integer\": 3, \"double\": 0.432, \"string\": \"string\", \"bool\": true}}".dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let dictionary: Dictionary<String, IDTestObject> = try parser.parseObject(jsonData)
            XCTAssertEqual(dictionary["object"], TestData.singleObjectResult)
        }catch {
            XCTFail()
        }
    }
}
