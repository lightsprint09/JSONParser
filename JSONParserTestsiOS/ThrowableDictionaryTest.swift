//
//  JSONTranformExtensionsTest.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 18.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import XCTest
@testable import JSONParser


class ThrowableDictionaryTest: XCTestCase {
    let parser = JSONParser()
    
    func testTranformToPrimitiv() {
        do {
            let dictionary: Dictionary<String, AnyObject> = try parser.parseFoundationObject(TestData.singleObject, JSONKeyPath: nil)
            let throwableDict = ThrowableDictionary(dictionary: dictionary)
            let obj: String = try throwableDict.valueFor("string")
            XCTAssertEqual(obj, "string")
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToObject() {
        do {
            let dictionary: Dictionary<String, AnyObject> = try parser.parseFoundationObject(TestData.singleObject, JSONKeyPath: nil)
            let throwableDict = ThrowableDictionary(dictionary: dictionary)
            let obj: IDTestObject = try throwableDict.valueFor()
            XCTAssertEqual(obj, TestData.singleObjectResult)
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToObjectWithKeyPath() {
        do {
            let dictionary: Dictionary<String, AnyObject> = try parser.parseFoundationObject(TestData.singleObjectKeyPath, JSONKeyPath: nil)
            let throwableDict = ThrowableDictionary(dictionary: dictionary)
            let obj: IDTestObject = try throwableDict.valueFor("keypath")
            XCTAssertEqual(obj, TestData.singleObjectResult)
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToListWithKeyPath() {
        do {
            let dictionary: Dictionary<String, AnyObject> = try parser.parseFoundationObject(TestData.listKeypath, JSONKeyPath: nil)
            let throwableDict = ThrowableDictionary(dictionary: dictionary)
            let obj: Array<IDTestObject> = try throwableDict.valueFor("innerList")
            XCTAssertEqual(obj.first, TestData.singleObjectResult)
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToPrimitiveType() {
        let data = "{ \"keyPath\": {\"keyPath\": \"string\"}}".dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let dictionary: Dictionary<String, AnyObject> = try parser.parseFoundationObject(data, JSONKeyPath: nil)
            let throwableDict: ThrowableDictionary = ThrowableDictionary(dictionary: dictionary)
            let obj: String = try throwableDict.valueFor("keyPath.keyPath")
            XCTAssertEqual(obj, "string")
        }catch {
            XCTFail()
        }
    }
    
    func testRawDictionaryData() {
        do {
            let dictionary: Dictionary<String, AnyObject> = try parser.parseFoundationObject(TestData.singleObject, JSONKeyPath: nil)
            let throwableDict: ThrowableDictionary = ThrowableDictionary(dictionary: dictionary)
            XCTAssertEqual(dictionary["string"] as? String, throwableDict.dictionary["string"]  as? String)
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToListOfPrimitiveType() {
        let jsonData = "{\"innerList\": [\"marco\",\"polo\"]}".dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let dictionary: Dictionary<String, AnyObject> = try parser.parseFoundationObject(jsonData, JSONKeyPath: nil)
            let throwableDict = ThrowableDictionary(dictionary: dictionary)
            let objs: Array<String> = try throwableDict.valueFor("innerList")
            XCTAssertEqual(objs.count, 2)
            XCTAssertEqual(objs.first, "marco")
            XCTAssertEqual(objs.last, "polo")
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToDictionaryOfPrimitiveType() {
        let jsonData = "{\"innerList\": {\"marco\": \"polo\"}}".dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let dictionary: Dictionary<String, AnyObject> = try parser.parseFoundationObject(jsonData, JSONKeyPath: nil)
            let throwableDict = ThrowableDictionary(dictionary: dictionary)
            let objs: Dictionary<String, String> = try throwableDict.valueFor("innerList")
            XCTAssertEqual(objs["marco"], "polo")
        }catch {
            XCTFail()
        }
    }
    

}