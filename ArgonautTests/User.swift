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
    let profilePictureURL: NSURL
    let location: CLLocation
    
    required init(name: String, profilePictureURL: NSURL, location: CLLocation) {
        self.name = name
        self.profilePictureURL = profilePictureURL
        self.location = location
    }
}

extension User: JSONDecodable {
    class func create(name: String)(profilePictureURL: NSURL)(location: CLLocation) -> User {
        return self(name: name, profilePictureURL: profilePictureURL, location: location)
    }
    
    class func decode(j: JSONValue) -> User? {
        return User.create
            <^> j <| "name"
            <*> j <| "profile_picture"
            <*> j <| "location"
    }
}