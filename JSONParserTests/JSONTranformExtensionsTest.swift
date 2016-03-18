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
            let dictionary: Dictionary<String, AnyObject> = try parser.parseObject(TestData.singleObject)
            let obj: IDTestObject? = dictionary.transformToObject()
            XCTAssertEqual(obj, TestData.singleObjectResult)
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToObjectWithKeyPath() {
        do {
            let dictionary: Dictionary<String, AnyObject> = try parser.parseObject(TestData.singleObjectKeyPath)
            let obj: IDTestObject? = dictionary.transformToObject(keyPath: "keypath")
            XCTAssertEqual(obj, TestData.singleObjectResult)
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToListWithKeyPath() {
        do {
            let dictionary: Dictionary<String, AnyObject> = try parser.parseObject(TestData.listKeypath)
            let obj: Array<IDTestObject>? = dictionary.transformToList(keyPath: "innerList")
            XCTAssertEqual(obj?.first, TestData.singleObjectResult)
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToPrimitiveType() {
        let data = "{ \"keyPath\": {\"keyPath\": \"string\"}}".dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let dictionary: Dictionary<String, AnyObject> = try parser.parseObject(data)
            let obj: String? = dictionary.transformToObject(keyPath: "keyPath.keyPath")
            XCTAssertEqual(obj, "string")
        }catch {
            XCTFail()
        }
    }
    
    func testTranformToListOfPrimitiveType() {
        let jsonData = "{\"innerList\": [\"marco\",\"polo\"]}".dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let dictionary: Dictionary<String, AnyObject> = try parser.parseObject(jsonData)
            let objs: Array<String> = dictionary.transformToList(keyPath: "innerList")!
            XCTAssertEqual(objs.count, 2)
            XCTAssertEqual(objs.first, "marco")
            XCTAssertEqual(objs.last, "polo")
        }catch {
            XCTFail()
        }
    }
    

}
