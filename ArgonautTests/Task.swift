//
//  Task.swift
//  Example
//
//  Created by Alexander Schuch on 03/04/15.
//  Copyright (c) 2015 Alexander Schuch. All rights reserved.
//

import Foundation
import Argonaut
import Argo
import Runes

class Task: NSObject {
    let name: String
 
    required init(name: String) {
        self.name = name
    }
}

extension Task: JSONDecodable {
    class func create(name: String) -> Task {
        return self(name: name)
    }
    
    class func decode(j: JSONValue) -> Task? {
        return Task.create
            <^> j <| "name"
    }
}
