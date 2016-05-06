//
//  JSONFetchingConvenience.swift
//  JSONParser
//
//  Created by Lukas Schmidt on 30.04.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//

import Foundation

public protocol JSONFetchingConvenience {
    /**
     Loads JSON from the given request and parses it to an ArrayType with elements conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: _ArrayType where T.Element: JSONParsable>(request: NSURLRequest, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->())
    
    /**
     Loads JSON from the given request and parses it to an ArrayType with elements conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter JSONKeyPath:     optional search path into JSON object for extracting result. Result must be an object
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: _ArrayType where T.Element: JSONParsable>(request: NSURLRequest,  JSONKeyPath: String?, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->())
    
    /**
     Loads JSON from the given request and parses it to an ArrayType with elements conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter context: Inject a context into the passable. E.g. be database access
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: _ArrayType where T.Element: JSONParsable>(request: NSURLRequest, context: T.Element.Context?, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->())
    
    /**
     Loads JSON from the given request and parses it to an dictionary with values conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: DictionaryLiteralConvertible where T.Value: JSONParsable>(request: NSURLRequest, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->())
    
    /**
     Loads JSON from the given request and parses it to an dictionary with values conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter JSONKeyPath:     optional search path into JSON object for extracting result. Result must be an object
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: DictionaryLiteralConvertible where T.Value: JSONParsable>(request: NSURLRequest,  JSONKeyPath: String?, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->())
    
    /**
     Loads JSON from the given request and parses it to an dictionary with values conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter context: Inject a context into the passable. E.g. be database access
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: DictionaryLiteralConvertible where T.Value: JSONParsable>(request: NSURLRequest, context: T.Value.Context?, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->())
    
    /**
     Loads JSON from the given request and parses it to an objec conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: JSONParsable>(request: NSURLRequest, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->())
    
    /**
     Loads JSON from the given request and parses it to an objec conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter JSONKeyPath:     optional search path into JSON object for extracting result. Result must be an object
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: JSONParsable>(request: NSURLRequest,  JSONKeyPath: String?, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->())
    
    /**
     Loads JSON from the given request and parses it to an objec conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter context: Inject a context into the passable. E.g. be database access
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: JSONParsable>(request: NSURLRequest, context: T.Context?, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->())
}