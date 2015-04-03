//
//  ArgonautTests.swift
//  ArgonautTests
//
//  Created by Alexander Schuch on 03/04/15.
//  Copyright (c) 2015 Alexander Schuch. All rights reserved.
//

import UIKit
import XCTest
import Argonaut

class JSONMappingTests: XCTestCase {
    
    let mockData = MockDataLoader()
        
    
    // MARK: Tests
    
    func testMapValidJSON() {
        XCTAssertNotNil(mockData.userJSONData, "user JSON data is nil")

        // NSData
        let user: User? = mapJSON(mockData.userJSONData)
        XCTAssertNotNil(user, "mapJSON returned nil user")
        
        // JSON object
        let user2: User? = mapJSON(mockData.userJSON)
        XCTAssertNotNil(user2, "mapJSON returned nil user")
    }
    
    func testMapArrayValidJSON() {
        XCTAssertNotNil(mockData.tasksJSONData, "tasks JSON data is nil")

        // NSData
        let tasks: [Task]? = mapJSONArray(mockData.tasksJSONData)
        XCTAssertNotNil(tasks, "mapJSON returned nil tasks")
        XCTAssertTrue(count(tasks!) == 3, "mapJSON returned wrong number of tasks")
        
        // JSON Object
        let tasks2: [Task]? = mapJSONArray(mockData.tasksJSON)
        XCTAssertNotNil(tasks2, "mapJSON returned nil tasks")
        XCTAssertTrue(count(tasks2!) == 3, "mapJSON returned wrong number of tasks")
    }

    func testMapNilJSON() {
        // NSData
        let data: NSData? = nil
        let user: User? = mapJSON(data)
        XCTAssertNil(user, "mapJSON returned non-nil user")
        
        // JSON Object
        let object: JSONObject? = nil
        let user2: User? = mapJSON(object)
        XCTAssertNil(user2, "mapJSON returned non-nil user")
    }

    func testMapArrayNilJSON() {
        // NSData
        let data: NSData? = nil
        let tasks: [Task]? = mapJSONArray(data)
        XCTAssertNil(tasks, "mapJSON returned non-nil tasks")
        
        // JSON Object
        let array: JSONArray? = nil
        let tasks2: [Task]? = mapJSONArray(array)
        XCTAssertNil(tasks2, "mapJSON returned non-nil tasks")
    }

    func testMapInvalidJSON() {
        // NSData
        let user: User? = mapJSON(mockData.invalidUserJSONData)
        XCTAssertNil(user, "mapJSON returned non-nil user")
        
        // JSON Object
        let user2: User? = mapJSON(mockData.invalidUserJSON)
        XCTAssertNil(user2, "mapJSON returned non-nil user")
    }
    
    func testMapArrayInvalidJSON() {
        // NSData
        let tasks: [Task]? = mapJSONArray(mockData.invalidTasksJSONData)
        XCTAssertNil(tasks, "mapJSON returned non-nil tasks")
        
        // JSON Object
        let tasks2: [Task]? = mapJSONArray(mockData.invalidTasksJSON)
        XCTAssertNil(tasks2, "mapJSON returned non-nil tasks")
    }
    
}
