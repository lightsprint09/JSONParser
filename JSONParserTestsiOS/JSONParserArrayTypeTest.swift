//
//  JSONParserArrayType.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 13.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

//
//  JSONParserTests.swift
//  JSONParserTests
//
//  Created by Lukas Schmidt on 11.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import XCTest
@testable import JSONParser

class JSONParserArrayTypeTest: XCTestCase {
    let parser = JSONParser()
    
    func testListKeypath() {
        do {
            let objects: Array<IDTestObject> = try parser.parseObject(data: TestData.listKeypath, JSONKeyPath: "innerList")
            XCTAssertEqual(objects.count, 1)
            let obj = objects.first!
            XCTAssertEqual(obj, TestData.singleObjectResult)
        }catch {
            XCTFail()
        }
    }
    
    func testList() {
        do {
            let objects: Array<IDTestObject> = try parser.parseObject(data: TestData.list, JSONKeyPath: nil)
            XCTAssertEqual(objects.count, 1)
            let obj = objects.first!
            XCTAssertEqual(obj, TestData.singleObjectResult)
        }catch {
            XCTFail()
        }
    }
    
    // ["marco", "polo"]
    func testListOfString() {
        let jsonData = "[\"marco\",\"polo\"]".data(using: String.Encoding.utf8)!
        do {
            let objs: Array<String> = try parser.parseObject(data: jsonData)
            XCTAssertEqual(objs.count, 2)
            XCTAssertEqual(objs.first, "marco")
            XCTAssertEqual(objs.last, "polo")
        }catch {
            XCTFail()
        }
    }
    
    // [1, 2]
    func testListOfDouble() {
        let jsonData = "[1.01, 2.02]".data(using: String.Encoding.utf8)!
        do {
            let objs: Array<Double> = try parser.parseObject(data: jsonData)
            XCTAssertEqual(objs.count, 2)
            XCTAssertEqual(objs.first, 1.01)
            XCTAssertEqual(objs.last, 2.02)
        }catch {
            XCTFail()
        }
    }
    
    func testListOfInteger() {
        let jsonData = "[1, 2]".data(using: String.Encoding.utf8)!
        do {
            let objs: Array<Double> = try parser.parseObject(data: jsonData)
            XCTAssertEqual(objs.count, 2)
            XCTAssertEqual(objs.first, 1)
            XCTAssertEqual(objs.last, 2)
        }catch {
            XCTFail()
        }
    }
    
    func testListOfBool() {
        let jsonData = "[true, false]".data(using: String.Encoding.utf8)!
        do {
            let objs: Array<Bool> = try parser.parseObject(data: jsonData)
            XCTAssertEqual(objs.count, 2)
            XCTAssertEqual(objs.first, true)
            XCTAssertEqual(objs.last, false)
        }catch {
            XCTFail()
        }
    }
    
    func testEmptyList() {
        let jsonData = "[]".data(using: String.Encoding.utf8)!
        do {
            let objs: Array<Bool> = try parser.parseObject(data: jsonData)
            XCTAssertEqual(objs.count, 0)
        }catch {
            XCTFail()
        }
    }
    
    func testInvalidData() {
        let jsonData = "[}".data(using: String.Encoding.utf8)!
        do {
            let _: Array<Bool> = try parser.parseObject(data: jsonData)
            XCTFail()
        }catch let error as NSError{
            XCTAssertNotNil(error)
        }
        
    }
    
}
