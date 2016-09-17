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

extension Task: Decodable {
    class func create(_ name: String) -> Task {
        return self.init(name: name)
    }
    
    class func decode(_ j: JSON) -> Decoded<Task> {
        return Task.create
            <^> j <| "name"
    }
}
