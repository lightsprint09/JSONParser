//
//  FindUpdateTestCase.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 11.05.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import XCTest
@testable import JSONParser

class FindUpdateTestCase: XCTestCase {
    let parser = JSONParser()
    var dataBase: NSMutableDictionary!
    
    override func setUp() {
        super.setUp()
        let obj1 = DataBaseObject(id: "1", name: "Lucas")
        dataBase = NSMutableDictionary(dictionary: ["1": obj1])
    }

    func testFindUpdate() {
        let jsonData = "{\"id\": \"1\", \"name\": \"Lukas\"}".dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let obj: DataBaseObject = try parser.parseObject(jsonData, context: dataBase)
            XCTAssertEqual(obj.name, "Lukas")
            XCTAssertNotNil(obj.notUpdateAble)
        }catch {
            XCTFail()
        }
    }
    
    func testInstert() {
        let jsonData = "{\"id\": \"2\", \"name\": \"Lukas\"}".dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            XCTAssertEqual(dataBase.allKeys.count, 1)
            let obj: DataBaseObject = try parser.parseObject(jsonData, context: dataBase)
            XCTAssertEqual(obj.name, "Lukas")
            XCTAssertNil(obj.notUpdateAble)
            XCTAssertEqual(dataBase.allKeys.count, 2)
        }catch {
            XCTFail()
        }
    }

}
