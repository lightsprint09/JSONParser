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
     Fetches data from an url conatining a list of JSON objects and parses it in a array of objects conforming JSONParsable
     
     - parameter url:         url to fetch the data from
     - parameter JSONKeyPath: keypath to optionally query into JSON object
     - parameter onSucess:    sucess callback
     - parameter onError:     error callback which passes JSONFetcherErrorType
     
     - returns: <#return value description#>
     */
    func loadList<T: JSONParsable>(request: NSURLRequest, JSONKeyPath: String?, onSucessHandler: (Array<T>)->(), onErrorHandler: (JSONFetcherErrorType)->())
    
    func loadObject<T: JSONParsable>(request: NSURLRequest, JSONKeyPath: String?, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->())
    
    func loadList<T: JSONParsable>(request: NSURLRequest, onSucessHandler: (Array<T>)->(), onErrorHandler: (JSONFetcherErrorType)->())
    
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


