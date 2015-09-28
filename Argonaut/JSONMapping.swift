//
//  JSONMapping.swift
//  Example
//
//  Created by Alexander Schuch on 03/04/15.
//  Copyright (c) 2015 Alexander Schuch. All rights reserved.
//

import Foundation
import Argo

// MARK: Direct object conversion

/// Creates an object from the given encoded JSON object
///
/// - parameter JSON: data
/// - returns: The decoded object
public func decodeData<T: Decodable where T == T.DecodedType>(data: NSData?) -> T? {
    if let json: AnyObject = JSONWithData(data) {
        return decode(json)
    }
    
    return .None
}

/// Creates an array of objects from the given encoded JSON array
///
/// - parameter JSON: data
/// - returns: An array containing the decoded objects
public func decodeData<T: Decodable where T == T.DecodedType>(data: NSData?) -> [T]? {
    if let json: AnyObject = JSONWithData(data) {
        return decode(json)
    }
    
    return .None
}


// MARK: Decoded type conversion

/// Creates an object from the given encoded JSON object
///
/// - parameter JSON: data
/// - returns: An instance of the `Decoded` type
public func decodeData<T: Decodable where T == T.DecodedType>(data: NSData?) -> Decoded<T>? {
    if let json: AnyObject = JSONWithData(data) {
        return decode(json)
    }
    
    return .None
}

/// Creates an array of objects from the given encoded JSON array
///
/// - parameter JSON: data
/// - returns: An instance of the `Decoded` type
public func decodeData<T: Decodable where T == T.DecodedType>(data: NSData?) -> Decoded<[T]>? {
    if let json: AnyObject = JSONWithData(data) {
        return decode(json)
    }
    
    return .None
}


// MARK: Private: JSON Serialization Helper

private func JSONWithData(data: NSData?) -> AnyObject? {
    if let data = data {
        return try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
    }
    
    return .None
}
