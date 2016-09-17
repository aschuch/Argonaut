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

    private func jsonData(_ name: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: name, withExtension: "json")!
        return try! Data(contentsOf: url)
    }



    // MARK: Data

    lazy var userJSONData: Data = self.jsonData("user")
    lazy var tasksJSONData: Data = self.jsonData("tasks")
    lazy var invalidUserJSONData: Data = self.jsonData("user_invalid")
    lazy var invalidTasksJSONData: Data = self.jsonData("tasks_invalid")
    lazy var userRootKeyJSONData: Data  = self.jsonData("user_rootkey")
    lazy var tasksRootKeyJSONData: Data = self.jsonData("tasks_rootkey")

    // MARK: JSON

    lazy var userJSON: [String: Any]  = {
        return try! JSONSerialization.jsonObject(with: self.userJSONData, options: []) as! [String: Any]
    }()
    
    lazy var tasksJSON: [[String: Any]]  = {
        return try! JSONSerialization.jsonObject(with: self.tasksJSONData, options: []) as! [[String: Any]]
    }()

    lazy var invalidUserJSON: [String: Any]  = {
        return try! JSONSerialization.jsonObject(with: self.invalidUserJSONData, options: []) as! [String: Any]
    }()
    
    lazy var invalidTasksJSON: [[String: Any]]  = {
        return try! JSONSerialization.jsonObject(with: self.invalidTasksJSONData, options: []) as! [[String: Any]]
    }()

    lazy var userRootKeyJSON: [String: Any]  = {
        return try! JSONSerialization.jsonObject(with: self.userRootKeyJSONData, options: []) as! [String: Any]
    }()

    lazy var tasksRootKeyJSON: [String: Any]  = {
        return try! JSONSerialization.jsonObject(with: self.tasksRootKeyJSONData, options: []) as! [String: Any]
    }()

}
