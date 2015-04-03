//
//  NSURLJSONExtension.swift
//  Example
//
//  Created by Alexander Schuch on 03/04/15.
//  Copyright (c) 2015 Alexander Schuch. All rights reserved.
//

import UIKit
import Argo

extension NSURL: JSONDecodable {
    public typealias DecodedType = NSURL
    
    public class func decode(j: JSONValue) -> DecodedType? {
        switch j {
        case .JSONString(let url): return NSURL(string: url)
        default: return .None
        }
    }
}
