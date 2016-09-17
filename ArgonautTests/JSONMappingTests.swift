//
//  ArgonautTests.swift
//  ArgonautTests
//
//  Created by Alexander Schuch on 03/04/15.
//  Copyright (c) 2015 Alexander Schuch. All rights reserved.
//

import UIKit
import XCTest
import Argo
import Argonaut

class JSONMappingTests: XCTestCase {
    
    let mockData = MockDataLoader()
        
    
    // MARK: Tests
    
    func testMapValidJSON() {
        XCTAssertNotNil(mockData.userJSONData, "user JSON data is nil")

        let user: User? = decodeData(mockData.userJSONData)
        let userDecoded: Decoded<User>? = decodeData(mockData.userJSONData)
        XCTAssertNotNil(user, "decodeData should return valid user")

        let u = userDecoded?.value
        XCTAssertNotNil(u, "decodeData decoded should return valid user")
    }
    
    func testMapArrayValidJSON() {
        XCTAssertNotNil(mockData.tasksJSONData, "tasks JSON data is nil")

        let tasks: [Task]? = decodeData(mockData.tasksJSONData)
        let tasksDecoded: Decoded<[Task]>? = decodeData(mockData.tasksJSONData)

        XCTAssertNotNil(tasks, "decodeData should return valid tasks")
        XCTAssertTrue((tasks!).count == 3, "decodeData returned wrong number of tasks")
        
        let t = tasksDecoded?.value
        XCTAssertNotNil(t, "decodeData decoded should return valid tasks")
        XCTAssertTrue((t!).count == 3, "decodeData decoded returned wrong number of tasks")
    }

    func testMapNilJSON() {
        let data: Data? = nil
        let tasks: [Task]? = decodeData(data)
        let tasksDecoded: Decoded<[Task]>? = decodeData(data)
        let user: User? = decodeData(data)
        let userDecoded: Decoded<User>? = decodeData(data)
        
        XCTAssert(tasks == nil, "decodeData should return nil tasks")
        XCTAssert(tasksDecoded == nil, "decodeData should return nil tasks")
        XCTAssert(user == nil, "decodeData should return nil user")
        XCTAssert(userDecoded == nil, "decodeData should return nil user")
    }

    func testMapInvalidJSON() {
        let tasks: [Task]? = decodeData(mockData.invalidTasksJSONData)
        let tasksDecoded: Decoded<[Task]>? = decodeData(mockData.invalidTasksJSONData)
        let user: User? = decodeData(mockData.invalidUserJSONData)
        let userDecoded: Decoded<User>? = decodeData(mockData.invalidUserJSONData)

        XCTAssert(tasks == nil, "decodeData should return nil tasks")
        XCTAssert(tasksDecoded?.value == nil, "decodeData decoded should return nil tasks \(tasksDecoded)")
        XCTAssert(user == nil, "decodeData should return nil user")
        XCTAssert(userDecoded?.value == nil, "decodeData decoded should return nil user")
    }
    
}
