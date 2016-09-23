//
//  JSONFetching.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 11.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation

public protocol JSONFetching {
    /**
     Loads JSON from the given request and parses it to an ArrayType with elements conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter JSONKeyPath:     optional search path into JSON object for extracting result. Result must be an object
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: RangeReplaceableCollection>(_ request: URLRequest, JSONKeyPath: String?, onSucessHandler: @escaping (T)->(), onErrorHandler: @escaping (JSONFetcherErrorType)->()) where T._Element: JSONParsable
    
    /**
     Loads JSON from the given request and parses it to an ArrayType with elements conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: RangeReplaceableCollection>(_ request: URLRequest, onSucessHandler: @escaping (T)->(), onErrorHandler: @escaping (JSONFetcherErrorType)->()) where T._Element: JSONParsable
    
    /**
     Loads JSON from the given request and parses it to an dictionary with values conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter JSONKeyPath:     optional search path into JSON object for extracting result. Result must be an object
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: ExpressibleByDictionaryLiteral>(_ request: URLRequest, JSONKeyPath: String?, onSucessHandler: @escaping (T)->(), onErrorHandler: @escaping (JSONFetcherErrorType)->()) where T.Value: JSONParsable
    
    /**
     Loads JSON from the given request and parses it to an dictionary with values conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: ExpressibleByDictionaryLiteral>(_ request: URLRequest, onSucessHandler: @escaping (T)->(), onErrorHandler: @escaping (JSONFetcherErrorType)->()) where T.Value: JSONParsable
    
    /**
      Loads JSON from the given request and parses it to an objec conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter JSONKeyPath:     optional search path into JSON object for extracting result. Result must be an object
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: JSONParsable>(_ request: URLRequest, JSONKeyPath: String?, onSucessHandler: @escaping (T)->(), onErrorHandler: @escaping (JSONFetcherErrorType)->())
    
    /**
     Loads JSON from the given request and parses it to an objec conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: JSONParsable>(_ request: URLRequest, onSucessHandler: @escaping (T)->(), onErrorHandler: @escaping (JSONFetcherErrorType)->())
}

public extension JSONFetching{
    public func loadObject<T: RangeReplaceableCollection>(_ request: URLRequest, onSucessHandler: @escaping (T)->(), onErrorHandler: @escaping (JSONFetcherErrorType)->())  where T._Element: JSONParsable {
        loadObject(request, onSucessHandler: onSucessHandler, onErrorHandler: onErrorHandler)
    }
    
    public func loadObject<T: ExpressibleByDictionaryLiteral>(_ request: URLRequest, onSucessHandler: @escaping (T)->(), onErrorHandler: @escaping (JSONFetcherErrorType)->()) where T.Value: JSONParsable {
        loadObject(request, JSONKeyPath: nil, onSucessHandler: onSucessHandler, onErrorHandler: onErrorHandler)
    }
    
    public func loadObject<T: JSONParsable>(_ request: URLRequest, onSucessHandler: @escaping (T)->(), onErrorHandler: @escaping (JSONFetcherErrorType)->()) {
        loadObject(request, JSONKeyPath: nil, onSucessHandler: onSucessHandler, onErrorHandler: onErrorHandler)
    }
}


