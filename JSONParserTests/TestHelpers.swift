//
//  TestHelpers.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 13.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation
@testable import JSONParser


struct IDTestObject:  JSONParsable{
    let id: Int
    
    init(JSON: Dictionary<String, AnyObject>) {
        self.id = JSON["id"] as! Int
    }
}