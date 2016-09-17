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
public func decodeData<T: Decodable>(_ data: Data?) -> T? where T == T.DecodedType {
    if let json = JSONWithData(data) {
        return decode(json)
    }
    
    return .none
}

/// Creates an array of objects from the given encoded JSON array
///
/// - parameter JSON: data
/// - returns: An array containing the decoded objects
public func decodeData<T: Decodable>(_ data: Data?) -> [T]? where T == T.DecodedType {
    if let json = JSONWithData(data) {
        return decode(json)
    }
    
    return .none
}


// MARK: Decoded type conversion

/// Creates an object from the given encoded JSON object
///
/// - parameter JSON: data
/// - returns: An instance of the `Decoded` type
public func decodeData<T: Decodable>(_ data: Data?) -> Decoded<T>? where T == T.DecodedType {
    if let json = JSONWithData(data) {
        return decode(json)
    }
    
    return .none
}

/// Creates an array of objects from the given encoded JSON array
///
/// - parameter JSON: data
/// - returns: An instance of the `Decoded` type
public func decodeData<T: Decodable>(_ data: Data?) -> Decoded<[T]>? where T == T.DecodedType {
    if let json = JSONWithData(data) {
        return decode(json)
    }
    
    return .none
}


// MARK: Private: JSON Serialization Helper

private func JSONWithData(_ data: Data?) -> Any? {
    if let data = data {
        return try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
    }
    
    return .none
}
