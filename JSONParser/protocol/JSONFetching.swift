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
    func loadList<T: JSONParsable>(request: NSURLRequest, JSONKeyPath: String, onSucess: (Array<T>)->(), onError: (JSONFetcherErrorType)->())
    
    func loadObject<T: JSONParsable>(request: NSURLRequest, JSONKeyPath: String, onSucess: (T)->(), onError: (JSONFetcherErrorType)->())
}
