//
//  CLLocation+Argo.swift
//  Example
//
//  Created by Alexander Schuch on 03/04/15.
//  Copyright (c) 2015 Alexander Schuch. All rights reserved.
//

import CoreLocation
import Argo

extension CLLocation: JSONDecodable {
    public typealias DecodedType = CLLocation
    
    public class func decode(j: JSONValue) -> DecodedType? {
        switch j {
        case .JSONObject(let dict):
            switch (dict["lat"], dict["lon"]) {
            case (.Some(.JSONNumber(let lat)), .Some(.JSONNumber(let lon))):
                return CLLocation(latitude: lat.doubleValue, longitude: lon.doubleValue)
            default:
                return .None
            }
        default:
            return .None
        }
    }
}
