//
//  JSONMapping+ReactiveCocoa.swift
//  Example
//
//  Created by Alexander Schuch on 03/04/15.
//  Copyright (c) 2015 Alexander Schuch. All rights reserved.
//

import Foundation
import Argo
import ReactiveCocoa

public typealias JSONObject = [String: AnyObject]
public typealias JSONArray = [JSONObject]
public let ArgonautErrorDomain = "com.aschuch.Argonaut.ErrorDomain"

/// Until ReactiveCocoa swift is commonly used, we need to constrain this method to NSObjects :/
extension RACSignal {
    
    /// Maps the given JSON object to an object of given classType
    ///
    /// :param: classType The type of the object that should be returned
    /// :returns: A new RACSignal emitting the decoded object
    public func mapToObject<T: protocol<NSObjectProtocol, JSONDecodable> where T == T.DecodedType>(classType: T.Type) -> RACSignal {
        return tryMap { (object, error) -> T! in
            if let json = object as? JSONObject {
                let o = JSONValue.parse(json)
                if let decoded = classType.decode(o) {
                    return decoded
                }
            }
            
            if error != nil {
                error.memory = NSError(domain: ArgonautErrorDomain, code: -1, userInfo: ["data": object])
            }
            
            return nil
        }
    }
    
    /// Maps the given JSON object array to an array of objects of the given classType
    ///
    /// :param: classType The type of the array that should be returned
    /// :returns: A new RACSignal emitting an array of decoded objects
    public func mapToObjectArray<T: protocol<NSObjectProtocol, JSONDecodable> where T == T.DecodedType>(classType: T.Type) -> RACSignal {
        return tryMap { (object, error) -> AnyObject! in
            if let json = object as? JSONArray {
                let o = JSONValue.parse(json)
                if let decoded: [T] = JSONValue.mapDecode(o) {
                    return decoded
                }
            }
            
            if error != nil {
                error.memory = NSError(domain: "JSON mapping Error", code: -1, userInfo: ["data": object])
            }
            
            return nil
        }
    }
    
}
