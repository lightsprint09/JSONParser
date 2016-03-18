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
     Loads JSON from the given request and parses it to an array of a type conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter JSONKeyPath:     optional search path into JSON object for extracting result. Result must be an array 
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `list` - The parsed list of objects of generic type T
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
    */
    func loadList<T: JSONParsable>(request: NSURLRequest, JSONKeyPath: String?, onSucessHandler: (Array<T>)->(), onErrorHandler: (JSONFetcherErrorType)->())
    
    /**
      Loads JSON from the given request and parses it to an array of a type conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `list` - The parsed list of objects of generic type T
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadList<T: JSONParsable>(request: NSURLRequest, onSucessHandler: (Array<T>)->(), onErrorHandler: (JSONFetcherErrorType)->())
    
    /**
      Loads JSON from the given request and parses it to an objec conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter JSONKeyPath:     optional search path into JSON object for extracting result. Result must be an object
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: JSONParsable>(request: NSURLRequest, JSONKeyPath: String?, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->())
    
    /**
     Loads JSON from the given request and parses it to an objec conforming to `JSONParsable`.
     
     - parameter request:         the request to fetch the JSON from
     - parameter onSucessHandler: the handler to execute when fetching and parsing succseed. The handler takes the following arguments:
     `object` - The parsed object generic type T conforming to `JSONParsable`
     - parameter onErrorHandler:  the handler to execute when fetching or parsing fails. The handler takes the following arguments:
     `error` - An error object that indicates why the fetching or parsing failed
     */
    func loadObject<T: JSONParsable>(request: NSURLRequest, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->())
}

extension JSONFetching{
    public func loadList<T: JSONParsable>(request: NSURLRequest, onSucessHandler: (Array<T>)->(), onErrorHandler: (JSONFetcherErrorType)->()) {
        loadList(request, JSONKeyPath: nil, onSucessHandler: onSucessHandler, onErrorHandler: onErrorHandler)
    }
    
    public func loadObject<T: JSONParsable>(request: NSURLRequest, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->()) {
        loadObject(request, JSONKeyPath: nil, onSucessHandler: onSucessHandler, onErrorHandler: onErrorHandler)
    }
}


