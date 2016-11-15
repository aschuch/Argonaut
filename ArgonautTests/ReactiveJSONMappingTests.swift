//
//  ReactiveJSONMappingTests.swift
//  Example
//
//  Created by Alexander Schuch on 03/04/15.
//  Copyright (c) 2015 Alexander Schuch. All rights reserved.
//

import UIKit
import XCTest
import ReactiveSwift
import Argonaut
import Result

class ReactiveJSONMappingTests: XCTestCase {

    let mockData = MockDataLoader()
    
    lazy var userJSONSignalProducer: SignalProducer<Any, NSError> = {
        return SignalProducer(value: self.mockData.userJSON)
    }()
    
    lazy var tasksJSONSignalProducer: SignalProducer<Any, NSError> = {
        return SignalProducer(value: self.mockData.tasksJSON)
    }()

    lazy var invalidTasksJSONSignalProducer: SignalProducer<Any, NSError> = {
        return SignalProducer(value: self.mockData.invalidTasksJSON)
    }()

    lazy var tasksRootKeyJSONSignalProducer: SignalProducer<Any, NSError> = {
        return SignalProducer(value: self.mockData.tasksRootKeyJSON)
    }()

    lazy var userRootKeyJSONSignalProducer: SignalProducer<Any, NSError> = {
        return SignalProducer(value: self.mockData.userRootKeyJSON)
    }()

    func testMapToObject() {
        var user: User?
        userJSONSignalProducer
            .mapToType(User.self)
            .startWithResult { user = $0.value }

        XCTAssertNotNil(user, "mapToType should not return nil user")
    }
    
    func testMapToObjectArray() {
        var tasks: [Task]?
        tasksJSONSignalProducer
            .mapToTypeArray(Task.self)
            .startWithResult { tasks = $0.value }

        XCTAssertNotNil(tasks, "mapToType should not return nil tasks")
        XCTAssertTrue((tasks!).count == 3, "mapJSON returned wrong number of tasks")
    }
    
    func testInvalidTasks() {
        var invalidTasks: [Task]? = nil
        invalidTasksJSONSignalProducer
            .mapToTypeArray(Task.self)
            .startWithResult { invalidTasks = $0.value }
        
        XCTAssert(invalidTasks == nil, "mapToType should return nil tasks for invalid JSON")
    }
    
    func testUnderlyingError() {
        var error: ArgonautError?
        let sentError = NSError(domain: "test", code: -9000, userInfo: nil)
        let (signal, sink) = Signal<Any, NSError>.pipe()
        
        signal.mapToType(User.self).observeFailed { error = $0 }
        sink.send(error: sentError)
        
        XCTAssertNotNil(error, "error should not be nil")
        XCTAssertEqual(error?.nsError, sentError, "the sent error should be wrapped in an .Underlying error")
    }

    func testMapToObjectRootKey() {
        var user: User?
        userRootKeyJSONSignalProducer
            .mapToType(User.self, rootKey: "user")
            .startWithResult { user = $0.value }

        XCTAssertNotNil(user, "mapToType should not return nil user")
    }

    func testMapToObjectArrayRootKey() {
        var tasks: [Task]?
        tasksRootKeyJSONSignalProducer
            .mapToTypeArray(Task.self, rootKey: "tasks")
            .startWithResult { tasks = $0.value }

        XCTAssertNotNil(tasks, "mapToType should not return nil tasks")
        XCTAssertTrue((tasks!).count == 3, "mapJSON returned wrong number of tasks")
    }
}
