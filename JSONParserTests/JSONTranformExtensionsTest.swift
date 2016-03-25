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

extension Dictionary where Key: StringLiteralConvertible {
    
    public func transformToObject<T: JSONParsable>() -> T? {
        return transformToObject(keyPath: nil)
    }
    
    public func transformToObject<T: JSONParsable>(keyPath keyPath: String?) -> T? {
        guard let JSON = transformJSON(keyPath: keyPath) as AnyObject? else { return nil }
        if let result = JSON as? T {
            return result
        }
        guard let dictJSON = JSON as? Dictionary<String, AnyObject> else { return nil }
        let trowableDict = ThrowableDictionary<String, AnyObject>(dictionary: dictJSON)
        return try? T(JSON: trowableDict)
        
    }
    
    public func transformToList<T: JSONParsable>(keyPath keyPath: String) -> Array<T>? {
        guard let JSON = transformJSON(keyPath: keyPath) as AnyObject? else { return nil }
        if let result = JSON as? Array<T> {
            return result
        }
        guard let arrayJSON = JSON as? Array<Dictionary<String, AnyObject>> else { return nil }
        
        return try? arrayJSON.map{ dict in
            let trowableDict = ThrowableDictionary<String, AnyObject>(dictionary: dict)
            return try T(JSON: trowableDict) }
    }
    //TODO: Find less hacky solution
    private func transformJSON<T>(keyPath keyPath: String?) -> T? {
        guard let dictionaryValue = self as? NSDictionary else { return nil}
        if let keyPath = keyPath, let JSON = dictionaryValue.valueForKeyPath(keyPath) as? T {
            return JSON
        }
        return dictionaryValue as? T
    }
}
