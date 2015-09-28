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
    
    lazy var userJSONSignalProducer: SignalProducer<AnyObject, NSError> = {
        return SignalProducer { sink, disposable in
            sendNext(sink, self.mockData.userJSON)
        }
    }()
    
    lazy var tasksJSONSignalProducer: SignalProducer<AnyObject, NSError> = {
        return SignalProducer { sink, disposable in
            sendNext(sink, self.mockData.tasksJSON)
        }
    }()
    
    
    lazy var invalidTasksJSONSignalProducer: SignalProducer<AnyObject, NSError> = {
        return SignalProducer { sink, disposable in
            sendNext(sink, self.mockData.invalidTasksJSONData)
        }
    }()
    
    
    func testMapToObject() {
        var user: User?
        userJSONSignal.mapToType(User.self).subscribeNext { user = $0 as? User }
        XCTAssertNotNil(user, "mapToObject returned nil user")
    }
    
    func testMapToObjectArray() {
        var tasks: [Task]?
        tasksJSONSignal.mapToTypeArray(Task.self).subscribeNext { tasks = $0 as? [Task] }
        XCTAssertNotNil(tasks, "mapToObject returned nil tasks")
        XCTAssertTrue((tasks!).count == 3, "mapJSON returned wrong number of tasks")
    }
    
    func testEmptySignal() {
        let signal = RACSignal.empty()
        
        var user: User?
        signal.mapToType(User.self).subscribeNext { user = $0 as? User }
        XCTAssertNil(user, "mapToObject returned non-nil user")
        
        var tasks: [Task]?
        signal.mapToTypeArray(Task.self).subscribeNext { tasks = $0 as? [Task] }
        XCTAssertNil(tasks, "mapToObject returned non-nil tasks")
    }
    
    func testRAC3() {
        var user: User?
        userJSONSignalProducer
            .mapToType(User.self)
            .startWithNext { user = $0 }
        
        XCTAssertNotNil(user, "mapToType should not return nil user")
        
        var tasks: [Task]?
        tasksJSONSignalProducer
            .mapToType(Task.self)
            .startWithNext { tasks = $0 }
        
        XCTAssertNotNil(tasks, "mapToType should not return nil tasks")
        
        var invalidTasks: [Task]? = nil
        invalidTasksJSONSignalProducer
            .mapToType(Task.self)
            .startWithNext { invalidTasks = $0 }
        
        XCTAssert(invalidTasks == nil, "mapToType should return nil tasks for invalid JSON")
    }
    
}
