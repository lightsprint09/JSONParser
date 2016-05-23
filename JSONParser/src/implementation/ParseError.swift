//
//  ParseError.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 22.05.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//  Based on John Sundell Unboxer - https://github.com/JohnSundell/Unbox
//

import Foundation

public enum ParseError: ErrorType, CustomStringConvertible {
    public var description: String {
        let baseDescription = "[JSON Parser error] "
        
        switch self {
        case .MissingKey(let key):
            return baseDescription + "Missing key (\(key))"
        case .InvalidValue(let key, let valueDescription):
            return baseDescription + "Invalid value (\(valueDescription)) for key (\(key))"
        case .InvalidData:
            return baseDescription + "Invalid NSData"
        }
    }
    
    /// Thrown when a required key was missing in an unboxed dictionary. Contains the missing key.
    case MissingKey(String)
    /// Thrown when a required key contained an invalid value in an unboxed dictionary. Contains the invalid
    /// key and a description of the invalid data.
    case InvalidValue(String, String)
    /// Thrown when a piece of data (NSData) could not be unboxed because it was considered invalid
    case InvalidData
}