//
//  JSONEncodable.swift
//  Example
//
//  Created by Alexander Schuch on 03/04/15.
//  Copyright (c) 2015 Alexander Schuch. All rights reserved.
//

import Foundation

/// A simple protocol to encode models back to JSON
public protocol JSONEncodable {
    func toJSON() -> JSONObject
}
