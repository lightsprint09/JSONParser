//
//  FoundationParserTest.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 13.04.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import XCTest
@testable import JSONParser

class FoundationParserTest: XCTestCase {
    let parser = FoundationParser()
    
    func testWrongContainerType() {
        do {
            let _: IDTestObject = try parser.parse(container: NSDate(), keyPath: nil)
            XCTFail()
        }catch let err as NSError{
            XCTAssertNotNil(err)
        }
    }
}
