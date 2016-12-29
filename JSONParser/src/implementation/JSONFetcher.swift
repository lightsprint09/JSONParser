//
//  JSONFetcher.swift
//  DBFahrplanAPI
//
//  Created by Lukas Schmidt on 01.03.16.
//  Copyright © 2016 Lukas Schmidt. All rights reserved.
//


import Foundation

public enum JSONFetcherErrorType: Error {
    case parse(ParseError)
    case network(Error?, String)
}


public struct JSONFetcher: JSONFetching {
    fileprivate let urlSession: URLSession
    fileprivate let jsonParser: JSONParser = JSONParser()
    
    public init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    public func loadObject<T : Collection>(_ request: URLRequest, JSONKeyPath: String?, onSucessHandler: @escaping (T) -> (), onErrorHandler: @escaping (JSONFetcherErrorType) -> ())  where T._Element: JSONParsable {
            loadJSONData(request, onSucessHandler: { data in
                func parse() throws -> T {
                    return try self.jsonParser.parseObject(data, JSONKeyPath: JSONKeyPath)
                }
                self.handleParsing(data, parse: parse, onSucces: onSucessHandler, onError: onErrorHandler)
            }, onErrorHandler: onErrorHandler)
    }
    
    public func loadObject<T : ExpressibleByDictionaryLiteral>(_ request: URLRequest, JSONKeyPath: String?, onSucessHandler: @escaping (T) -> (), onErrorHandler: @escaping (JSONFetcherErrorType) -> ())  where T.Value : JSONParsable {
        loadJSONData(request, onSucessHandler: { data in
            func parse() throws -> T {
                return try self.jsonParser.parseObject(data, JSONKeyPath: JSONKeyPath)
            }
            self.handleParsing(data, parse: parse, onSucces: onSucessHandler, onError: onErrorHandler)
        }, onErrorHandler: onErrorHandler)
    }
    
    public func loadObject<T: JSONParsable>(_ request: URLRequest, JSONKeyPath: String?, onSucessHandler: @escaping (T)->(), onErrorHandler: @escaping (JSONFetcherErrorType)->()) {
        loadJSONData(request, onSucessHandler: { data in
            func parse() throws -> T {
                return try self.jsonParser.parseObject(data, JSONKeyPath: JSONKeyPath)
            }
            self.handleParsing(data, parse: parse, onSucces: onSucessHandler, onError: onErrorHandler)
        }, onErrorHandler: onErrorHandler)
    }
    
    fileprivate func handleParsing<Result: Any>(_ data: Data, parse: () throws -> Result, onSucces:@escaping (Result)->(), onError: @escaping (JSONFetcherErrorType)->()){
        do {
            let obj = try parse()
            DispatchQueue.main.async(execute: {
                onSucces(obj)
            })
        }
        catch let error as ParseError{
            DispatchQueue.main.async(execute: {
                onError(.parse(error))
            })
        }catch {}
    }
    
    
    /**
     Loads Data from an given request
     
     - parameter request:  the reuqest to recieve the data from
     - parameter onSucessHandler: the handler to execute when the request succeeds. The handler takes the following arguments:
                                `data` - The data returned by the request
     
     - parameter onErrorHandler:  the handler to execute when the request fails. The handler takes the following arguments:
            `error` - An error object that indicates why the request failed
     */
    fileprivate func loadJSONData(_ request: URLRequest, onSucessHandler: @escaping (Data)->(), onErrorHandler: @escaping (JSONFetcherErrorType)->()) {
        let task = urlSession.dataTask(with: request) {data, response, error in
            if let error = error {
                return onErrorHandler(.network(error, "Network error"))
            }
            guard let data = data else {
                return onErrorHandler(.network(error, "Empty data result"))
            }
            onSucessHandler(data)
        }
        
        task.resume()
    }
    
    
}



