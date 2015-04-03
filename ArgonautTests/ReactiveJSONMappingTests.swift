//
//  ReactiveJSONMappingTests.swift
//  Example
//
//  Created by Alexander Schuch on 03/04/15.
//  Copyright (c) 2015 Alexander Schuch. All rights reserved.
//

import UIKit
import XCTest
import ReactiveCocoa
import Argonaut

class ReactiveJSONMappingTests: XCTestCase {

    let mockData = MockDataLoader()
    
    lazy var userJSONSignal: RACSignal = {
        return RACSignal.createSignal { (subscriber) -> RACDisposable! in
            subscriber.sendNext(self.mockData.userJSON)
            return RACDisposable()
        }
    }()
    
    lazy var tasksJSONSignal: RACSignal = {
        return RACSignal.createSignal { (subscriber) -> RACDisposable! in
            subscriber.sendNext(self.mockData.tasksJSON)
            return RACDisposable()
        }
    }()
    
    func testMapToObject() {
        var user: User?
        userJSONSignal.mapToObject(User.self).subscribeNext { user = $0 as? User }
        XCTAssertNotNil(user, "mapToObject returned nil user")
    }
    
    func testMapToObjectArray() {
        var tasks: [Task]?
        tasksJSONSignal.mapToObjectArray(Task.self).subscribeNext { tasks = $0 as? [Task] }
        XCTAssertNotNil(tasks, "mapToObject returned nil tasks")
        XCTAssertTrue(count(tasks!) == 3, "mapJSON returned wrong number of tasks")
    }
    
    func testEmptySignal() {
        let signal = RACSignal.empty()
        
        var user: User?
        signal.mapToObject(User.self).subscribeNext { user = $0 as? User }
        XCTAssertNil(user, "mapToObject returned non-nil user")
        
        var tasks: [Task]?
        signal.mapToObjectArray(Task.self).subscribeNext { tasks = $0 as? [Task] }
        XCTAssertNil(tasks, "mapToObject returned non-nil tasks")
    }
    
}
