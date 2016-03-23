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
        return SignalProducer(value: self.mockData.userJSON)
    }()
    
    lazy var tasksJSONSignalProducer: SignalProducer<AnyObject, NSError> = {
        return SignalProducer(value: self.mockData.tasksJSON)
    }()
    
    
    lazy var invalidTasksJSONSignalProducer: SignalProducer<AnyObject, NSError> = {
        return SignalProducer(value: self.mockData.invalidTasksJSONData)
    }()
    
    
    func testMapToObject() {
        var user: User?
        userJSONSignalProducer
            .mapToType(User)
            .startWithNext { user = $0 }

        XCTAssertNotNil(user, "mapToType should not return nil user")
    }
    
    func testMapToObjectArray() {
        var tasks: [Task]?
        tasksJSONSignalProducer
            .mapToTypeArray(Task)
            .startWithNext { tasks = $0 }

        XCTAssertNotNil(tasks, "mapToType should not return nil tasks")
        XCTAssertTrue((tasks!).count == 3, "mapJSON returned wrong number of tasks")
    }
    
    func testInvalidTasks() {
        var invalidTasks: [Task]? = nil
        invalidTasksJSONSignalProducer
            .mapToTypeArray(Task)
            .startWithNext { invalidTasks = $0 }
        
        XCTAssert(invalidTasks == nil, "mapToType should return nil tasks for invalid JSON")
    }
    
    func testUnderlyingError() {
        var error: ArgonautError?
        let sentError = NSError(domain: "test", code: -9000, userInfo: nil)
        let (producer, observer) = SignalProducer<AnyObject, NSError>.buffer(1)
        
        producer.mapToType(User).startWithFailed { error = $0 }
        observer.sendFailed(sentError)
        
        XCTAssertNotNil(error, "error should not be nil")
        XCTAssertEqual(error?.nsError, sentError, "the sent error should be wrapped in an .Underlying error")
    }
}
