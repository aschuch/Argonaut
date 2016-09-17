//
//  MockDataLoader.swift
//  Example
//
//  Created by Alexander Schuch on 03/04/15.
//  Copyright (c) 2015 Alexander Schuch. All rights reserved.
//

import Foundation
import Argonaut

class MockDataLoader {

    lazy var userJSONData: Data  = {
        let path = Bundle(for: type(of: self)).path(forResource: "user", ofType: "json")!
        return (try! Data(contentsOf: URL(fileURLWithPath: path)))
        }()
    
    lazy var tasksJSONData: Data  = {
        let path = Bundle(for: type(of: self)).path(forResource: "tasks", ofType: "json")!
        return (try! Data(contentsOf: URL(fileURLWithPath: path)))
        }()
    
    lazy var userJSON: [String: Any]  = {
        return try! JSONSerialization.jsonObject(with: self.userJSONData, options: JSONSerialization.ReadingOptions()) as! [String: Any]
        }()
    
    lazy var tasksJSON: [[String: Any]]  = {
        return try! JSONSerialization.jsonObject(with: self.tasksJSONData, options: JSONSerialization.ReadingOptions()) as! [[String: Any]]
        }()
    
    lazy var invalidUserJSONData: Data  = {
        let path = Bundle(for: type(of: self)).path(forResource: "user_invalid", ofType: "json")!
        return (try! Data(contentsOf: URL(fileURLWithPath: path)))
        }()
    
    lazy var invalidTasksJSONData: Data  = {
        let path = Bundle(for: type(of: self)).path(forResource: "tasks_invalid", ofType: "json")!
        return (try! Data(contentsOf: URL(fileURLWithPath: path)))
        }()
    
    lazy var invalidUserJSON: [String: Any]  = {
        return try! JSONSerialization.jsonObject(with: self.invalidUserJSONData, options: JSONSerialization.ReadingOptions()) as! [String: Any]
        }()
    
    lazy var invalidTasksJSON: [[String: Any]]  = {
        return try! JSONSerialization.jsonObject(with: self.invalidTasksJSONData, options: JSONSerialization.ReadingOptions()) as! [[String: Any]]
    }()

}
