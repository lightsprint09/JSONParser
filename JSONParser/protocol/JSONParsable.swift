//
//  JSONParsable.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 11.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation

public protocol JSONParsable {
    init(JSON: Dictionary<String, AnyObject>)
}