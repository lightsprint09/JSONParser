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
    func loadObject<T: _ArrayType where T.Element: JSONParsable>(request: NSURLRequest, JSONKeyPath: String?, context: T.Element.Context?, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->())
    
    /**
     Loads JSON from the given request and parses it to an dictionary with values conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter JSONKeyPath:     optional search path into JSON object for extracting result. Result must be an object
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: DictionaryLiteralConvertible where T.Value: JSONParsable>(request: NSURLRequest, JSONKeyPath: String?, context: T.Value.Context?, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->())
    
    /**
      Loads JSON from the given request and parses it to an objec conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter JSONKeyPath:     optional search path into JSON object for extracting result. Result must be an object
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: JSONParsable>(request: NSURLRequest, JSONKeyPath: String?, context: T.Context?, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->())
}

public extension JSONFetching {
    public func loadObject<T: _ArrayType where T.Element: JSONParsable>(request: NSURLRequest, JSONKeyPath: String? = nil, context: T.Element.Context? = nil, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->()) {
        loadObject(request, JSONKeyPath: JSONKeyPath, context: context, onSucessHandler: onSucessHandler, onErrorHandler: onErrorHandler)
    }
    
    public func loadObject<T: DictionaryLiteralConvertible where T.Value: JSONParsable>(request: NSURLRequest, JSONKeyPath: String? = nil, context: T.Value.Context? = nil, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->()) {
        loadObject(request, JSONKeyPath: JSONKeyPath, context: context, onSucessHandler: onSucessHandler, onErrorHandler: onErrorHandler)
    }
    
    public func loadObject<T: JSONParsable>(request: NSURLRequest, JSONKeyPath: String? = nil, context: T.Context? = nil, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->()) {
        loadObject(request, JSONKeyPath: JSONKeyPath, context: context, onSucessHandler: onSucessHandler, onErrorHandler: onErrorHandler)
    }
}


