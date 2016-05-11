//
//  DataBaseJSONParsable.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 11.05.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation

public protocol DataBaseJSONParsable {
    associatedtype Context
    static func find(JSON: ThrowableDictionary<Context>) throws -> Self?
    func updateWith(JSON: ThrowableDictionary<Context>) throws -> Self
}

