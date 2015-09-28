//
//  User.swift
//  Example
//
//  Created by Alexander Schuch on 03/04/15.
//  Copyright (c) 2015 Alexander Schuch. All rights reserved.
//

import Foundation
import Argonaut
import Argo
import Runes
import CoreLocation

class User: NSObject {
    let name: String
    
    required init(name: String) {
        self.name = name
    }
}

extension User: Decodable {
    class func create(name: String) -> User {
        return self.init(name: name)
    }
    
    class func decode(j: JSON) -> Decoded<User> {
        return User.create
            <^> j <| "name"
    }
}