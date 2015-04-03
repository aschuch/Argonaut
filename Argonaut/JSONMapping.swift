//
//  JSONMapping.swift
//  Example
//
//  Created by Alexander Schuch on 03/04/15.
//  Copyright (c) 2015 Alexander Schuch. All rights reserved.
//

import UIKit
import Argo

/// Creates an object from the given encoded JSON object
///
/// :param: JSON data
/// :returns: The decoded object
public func mapJSON<T: JSONDecodable where T == T.DecodedType>(data: NSData?) -> T? {
    if let json = JSONWithData(data) as? JSONObject {
        return mapJSON(json)
    }
    
    return .None
}

/// Creates an array of objects from the given encoded JSON array
///
/// :param: JSON data
/// :returns: An array containing the decoded objects
public func mapJSONArray<T: JSONDecodable where T == T.DecodedType>(data: NSData?) -> [T]? {
    if let json = JSONWithData(data) as? JSONArray {
        return mapJSONArray(json)
    }
    
    return .None
}

/// Creates an object from the given JSON object
///
/// :param: JSON data
/// :returns: The decoded object
public func mapJSON<T: JSONDecodable where T == T.DecodedType>(object: JSONObject?) -> T? {
    if let json = object {
        let o = JSONValue.parse(json)
        return T.decode(o)
    }
    
    return .None
}

/// Creates an array of objects from the given JSON array
///
/// :param: JSON data
/// :returns: An array containing the decoded objects
public func mapJSONArray<T: JSONDecodable where T == T.DecodedType>(array: JSONArray?) -> [T]? {
    if let json = array {
        let o = JSONValue.parse(json)
        return JSONValue.mapDecode(o)
    }
    
    return .None
}


// MARK: JSON Serialization Helper

private func dataWithJSON(json: JSONObject?) -> NSData? {
    if let json = json {
        return NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions(), error: nil)
    }
    
    return .None
}

private func JSONWithData(data: NSData?) -> AnyObject? {
    if let data = data {
        return NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(), error: nil)
    }
    
    return .None
}
