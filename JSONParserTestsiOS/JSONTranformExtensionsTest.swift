//
//  JSONTranformExtensionsTest.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 18.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import XCTest
@testable import JSONParser


class JSONTranformExtensionsTest: XCTestCase {
    let parser = JSONParser()
    
    func testTranformToObject() {
        do {
            let dictionary: Dictionary<String, AnyObject> = try parser.parseFoundationObject(TestData.singleObject, JSONKeyPath: nil)
            let throwableDict = ThrowableDictionary<String, AnyObject>(dictionary: dictionary)
            let obj: IDTestObject = try throwableDict.transformToObject()
            XCTAssertEqual(obj, TestData.singleObjectResult)
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToObjectWithKeyPath() {
        do {
            let dictionary: Dictionary<String, AnyObject> = try parser.parseFoundationObject(TestData.singleObjectKeyPath, JSONKeyPath: nil)
            let throwableDict = ThrowableDictionary<String, AnyObject>(dictionary: dictionary)
            let obj: IDTestObject = try throwableDict.transformToObject(keyPath: "keypath")
            XCTAssertEqual(obj, TestData.singleObjectResult)
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToListWithKeyPath() {
        do {
            let dictionary: Dictionary<String, AnyObject> = try parser.parseFoundationObject(TestData.listKeypath, JSONKeyPath: nil)
            let throwableDict = ThrowableDictionary<String, AnyObject>(dictionary: dictionary)
            let obj: Array<IDTestObject> = try throwableDict.transformToList(keyPath: "innerList")
            XCTAssertEqual(obj.first, TestData.singleObjectResult)
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToPrimitiveType() {
        let data = "{ \"keyPath\": {\"keyPath\": \"string\"}}".dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let dictionary: Dictionary<String, AnyObject> = try parser.parseFoundationObject(data, JSONKeyPath: nil)
            let throwableDict: ThrowableDictionary = ThrowableDictionary<String, AnyObject>(dictionary: dictionary)
            let obj: String = try throwableDict.transformToObject(keyPath: "keyPath.keyPath")
            XCTAssertEqual(obj, "string")
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToListOfPrimitiveType() {
        let jsonData = "{\"innerList\": [\"marco\",\"polo\"]}".dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let dictionary: Dictionary<String, AnyObject> = try parser.parseFoundationObject(jsonData, JSONKeyPath: nil)
            let throwableDict: ThrowableDictionary = ThrowableDictionary<String, AnyObject>(dictionary: dictionary)
            let objs: Array<String> = try throwableDict.transformToList(keyPath: "innerList")
            XCTAssertEqual(objs.count, 2)
            XCTAssertEqual(objs.first, "marco")
            XCTAssertEqual(objs.last, "polo")
        }catch {
            XCTFail()
        }
    }
    

}