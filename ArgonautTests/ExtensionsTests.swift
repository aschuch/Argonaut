//
//  ExtensionsTests.swift
//  Example
//
//  Created by Alexander Schuch on 03/04/15.
//  Copyright (c) 2015 Alexander Schuch. All rights reserved.
//

import UIKit
import XCTest
import Argo
import Argonaut
import CoreLocation

class ExtensionsTests: XCTestCase {
    
    func testNSURL() {
        let urlString = "http://example.com"
        let json = ["url": urlString]
        let j = JSONValue.parse(json)
        
        let url: NSURL? = j <| "url"
        XCTAssertNotNil(url, "url is nil")
        XCTAssertEqual(url!.absoluteString!, urlString, "url output != url input")
    }

    func testCLLocation() {
        let lat = 11.44384
        let lon = 22.55897
        
        let json = [
            "location": [
                "lat": lat,
                "lon": lon
            ]
        ]
        
        let j = JSONValue.parse(json)
        
        let location: CLLocation? = j <| "location"
        XCTAssertNotNil(location, "location is nil")
        XCTAssertEqual(location!.coordinate.latitude, lat, "lat output != lat input")
        XCTAssertEqual(location!.coordinate.longitude, lon, "lon output != lon input")
    }

}
