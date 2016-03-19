//
//  JSONFetcher.swift
//  DBFahrplanAPI
//
//  Created by Lukas Schmidt on 01.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//


//loadArray -> {t: []}, [{}, {}]
//?? -> [[], []]

import Foundation

public enum JSONFetcherErrorType: ErrorType {
    case Parse(String)
    case Network(String, NSError?)
}


public struct JSONFetcher: JSONFetching {
    private let urlSession: NSURLSession
    private let jsonParser: JSONParser = JSONParser()
    
    public init(urlSession: NSURLSession = NSURLSession.sharedSession()) {
        self.urlSession = urlSession
    }
    
    public func loadList<T: JSONParsable>(request: NSURLRequest, JSONKeyPath: String?, onSucessHandler: (Array<T>)->(), onErrorHandler: (JSONFetcherErrorType)->()) {
        func onSuccess(data: NSData) {
            do {
                let obj = try jsonParser.parseList(data, JSONKeyPath: JSONKeyPath) as Array<T>
                onSucessHandler(obj)
            }
            catch {
                onErrorHandler(.Parse(NSString(data: data, encoding: NSUTF8StringEncoding) as? (String) ?? "Error") )
            }
        }
        
        loadJSONData(request, onSucessHandler: onSuccess, onErrorHandler: onErrorHandler)
    }
    
    public func loadObject<T: JSONParsable>(request: NSURLRequest, JSONKeyPath: String?, onSucessHandler: (T)->(), onErrorHandler: (JSONFetcherErrorType)->()) {
        func onSuccess(data: NSData) {
            do {
                let obj = try jsonParser.parseObject(data, JSONKeyPath: JSONKeyPath) as T
                onSucessHandler(obj)
            }
            catch {
                onErrorHandler(.Parse(NSString(data: data, encoding: NSUTF8StringEncoding) as? (String) ?? "Error"))
            }
        }
        
        loadJSONData(request, onSucessHandler: onSuccess, onErrorHandler: onErrorHandler)
    }
    
    
    /**
     Loads NSData from an given request
     
     - parameter request:  the reuqest to recieve the data from
     - parameter onSucessHandler: the handler to execute when the request succeeds. The handler takes the following arguments:
                                `data` - The data returned by the request
     
     - parameter onErrorHandler:  the handler to execute when the request fails. The handler takes the following arguments:
            `error` - An error object that indicates why the request failed
     */
    private func loadJSONData(request: NSURLRequest, onSucessHandler: (NSData)->(), onErrorHandler: (JSONFetcherErrorType)->()) {
        let task = urlSession.dataTaskWithRequest(request) {data, response, error in
            if let error = error {
                return onErrorHandler(.Network("Network error", error))
            }
            guard let data = data else {
                return onErrorHandler(.Network("Empty data result", error))
            }
            onSucessHandler(data)
        }
        
        task.resume()
    }
    
    
}



