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
            let dictionary: Dictionary<String, Any> = try parser.parseFoundationObject(data: TestData.singleObject)
            let throwableDict = ThrowableDictionary(dictionary: dictionary)
            let obj: String = try throwableDict.valueFor(keyPath: "string")
            XCTAssertEqual(obj, "string")
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToObject() {
        do {
            let dictionary: Dictionary<String, Any> = try parser.parseFoundationObject(data: TestData.singleObject)
            let throwableDict = ThrowableDictionary(dictionary: dictionary)
            let obj: IDTestObject = try throwableDict.valueFor()
            XCTAssertEqual(obj, TestData.singleObjectResult)
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToObjectWithKeyPath() {
        do {
            let dictionary: Dictionary<String, Any> = try parser.parseFoundationObject(data: TestData.singleObjectKeyPath)
            let throwableDict = ThrowableDictionary(dictionary: dictionary)
            let obj: IDTestObject = try throwableDict.valueFor(keyPath: "keypath")
            XCTAssertEqual(obj, TestData.singleObjectResult)
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToListWithKeyPath() {
        do {
            let dictionary: Dictionary<String, Any> = try parser.parseFoundationObject(data: TestData.listKeypath)
            let throwableDict = ThrowableDictionary(dictionary: dictionary)
            let obj: Array<IDTestObject> = try throwableDict.valueFor(keyPath: "innerList")
            XCTAssertEqual(obj.first, TestData.singleObjectResult)
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToPrimitiveType() {
        let data = "{ \"keyPath\": {\"keyPath\": \"string\"}}".data(using: String.Encoding.utf8)!
        do {
            let dictionary: Dictionary<String, Any> = try parser.parseFoundationObject(data: data)
            let throwableDict: ThrowableDictionary = ThrowableDictionary(dictionary: dictionary)
            let obj: String = try throwableDict.valueFor(keyPath: "keyPath.keyPath")
            XCTAssertEqual(obj, "string")
        }catch {
            XCTFail()
        }
    }
    
    func testRawDictionaryData() {
        do {
            let dictionary: Dictionary<String, Any> = try parser.parseFoundationObject(data: TestData.singleObject)
            let throwableDict: ThrowableDictionary = ThrowableDictionary(dictionary: dictionary)
            XCTAssertEqual(dictionary["string"] as? String, throwableDict.dictionary["string"]  as? String)
        }catch {
            XCTFail()
        }
    }
    
    func testInvalidKeyPath() {
        let jsonData = "{\"innerList\": [\"marco\",\"polo\"]}".data(using: String.Encoding.utf8)!
        do {
            let dictionary: Dictionary<String, Any> = try parser.parseFoundationObject(data: jsonData)
            let throwableDict = ThrowableDictionary(dictionary: dictionary)
            let t: Array<String> = try throwableDict.valueFor(keyPath: "innerList.kexpaty.t")
            print(t)
            XCTFail()
        }catch {
            
        }
    }
    
    func testTranformToListOfPrimitiveType() {
        let jsonData = "{\"innerList\": [\"marco\",\"polo\"]}".data(using: String.Encoding.utf8)!
        do {
            let dictionary: Dictionary<String, Any> = try parser.parseFoundationObject(data: jsonData)
            let throwableDict = ThrowableDictionary(dictionary: dictionary)
            let objs: Array<String> = try throwableDict.valueFor(keyPath: "innerList")
            XCTAssertEqual(objs.count, 2)
            XCTAssertEqual(objs.first, "marco")
            XCTAssertEqual(objs.last, "polo")
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToDictionaryOfPrimitiveType() {
        let jsonData = "{\"innerList\": {\"marco\": \"polo\"}}".data(using: String.Encoding.utf8)!
        do {
            let dictionary: Dictionary<String, Any> = try parser.parseFoundationObject(data: jsonData)
            let throwableDict = ThrowableDictionary(dictionary: dictionary)
            let objs: Dictionary<String, String> = try throwableDict.valueFor(keyPath: "innerList")
            XCTAssertEqual(objs["marco"], "polo")
        }catch {
            XCTFail()
        }
    }
    

}
