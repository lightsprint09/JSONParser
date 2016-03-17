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
    
    public func loadList<T: JSONParsable>(request: NSURLRequest, JSONKeyPath: String = "", onSucess: (Array<T>)->(), onError: (JSONFetcherErrorType)->()) {
        func onSuccess(data: NSData) {
            do {
                let obj = try jsonParser.parseList(data, JSONKeyPath: JSONKeyPath) as Array<T>
                onSucess(obj)
            }
            catch {
                onError(.Parse(NSString(data: data, encoding: NSUTF8StringEncoding) as? (String) ?? "Error") )
            }
        }
        
        loadJSONData(request, onSucess: onSuccess, onError: onError)
    }
    
    public func loadObject<T: JSONParsable>(request: NSURLRequest, JSONKeyPath: String = "", onSucess: (T)->(), onError: (JSONFetcherErrorType)->()) {
        func onSuccess(data: NSData) {
            do {
                let obj = try jsonParser.parseObject(data, JSONKeyPath: JSONKeyPath) as T
                onSucess(obj)
            }
            catch {
                onError(.Parse(NSString(data: data, encoding: NSUTF8StringEncoding) as? (String) ?? "Error"))
            }
        }
        
        loadJSONData(request, onSucess: onSuccess, onError: onError)
    }
    
    
    private func loadJSONData(request: NSURLRequest, onSucess: (NSData)->(), onError: (JSONFetcherErrorType)->()) {
        
        let task = urlSession.dataTaskWithRequest(request) {data, response, error in
            if let error = error {
                return onError(.Network("Network error", error))
            }
            guard let data = data else {
                return onError(.Network("Empty data result", error))
            }
            onSucess(data)
        }
        
        task.resume()
    }
    
    
}



