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
        let jsonData = "{\"id\": 3}".dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let obj: IDTestObject = try parser.parseObject(jsonData, JSONKeyPath: "")
            XCTAssertEqual(obj.id, 3)
        }catch {
            XCTFail()
        }
    }
    
    func testKepathObject() {
        let jsonData = "{\"keypath\": {\"id\": 7}}".dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let obj: IDTestObject = try parser.parseObject(jsonData, JSONKeyPath: "keypath")
            XCTAssertEqual(obj.id, 7)
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
}
