//
//  JSONMapping+ReactiveCocoa.swift
//  Example
//
//  Created by Alexander Schuch on 03/04/15.
//  Copyright (c) 2015 Alexander Schuch. All rights reserved.
//

import Foundation
import Argo
import ReactiveCocoa
import Result

public let ArgonautErrorDomain = "com.aschuch.Argonaut.ErrorDomain"

public struct ArgonautError: ErrorType {
    let type: String
    let reason: String
    
    public var nsError: NSError {
        return NSError(domain: ArgonautErrorDomain, code: -1, userInfo: [NSLocalizedFailureReasonErrorKey: "\(type): \(reason)"])
    }
}

// MARK: ReactiveCocoa <= 2.x

@available(*, deprecated, message="RACSignal extensions will be removed as soon as ReactiveCocoa 4 becomes final.")
extension RACSignal {
    
    /// Maps the given JSON object (AnyObject) to an object of given classType
    ///
    /// - parameter classType: The type of the object that should be returned
    /// - returns: A new RACSignal emitting the decoded object
    public func mapToType<T: protocol<NSObjectProtocol, Decodable> where T == T.DecodedType>(classType: T.Type) -> RACSignal {
        return tryMap { (object, error) -> T! in
            let decoded: Decoded<T> = decode(object)
            
            switch decoded {
            case .Success(let value):
                return value
            case .Failure(let failure):
                if error != nil {
                    error.memory = ArgonautError(type: String(T), reason: failure.description).nsError
                }
                return nil
            }
        }
    }
    
    
    /// Maps the given JSON object array to an array of objects of the given classType
    ///
    /// - parameter classType: The type of the array that should be returned
    /// - returns: A new RACSignal emitting an array of decoded objects
    public func mapToTypeArray<T: protocol<NSObjectProtocol, Decodable> where T == T.DecodedType>(classType: T.Type) -> RACSignal {
        return tryMap { (object, error) -> AnyObject! in
            let decoded: Decoded<[T]> = decode(object)
            
            switch decoded {
            case .Success(let value):
                return value
            case .Failure(let failure):
                if error != nil {
                    error.memory = ArgonautError(type: "[\(String(T))]", reason: failure.description).nsError
                }
                return nil
            }
        }
    }
    
}


// MARK: ReactiveCocoa >= 4.x

extension SignalType where Value == AnyObject, Error == NSError {
    
    /// Maps the given SON object within the stream to an object of given classType
    ///
    /// - parameter classType: The type of the object that should be returned
    /// - returns: A new Signal emitting the decoded object
    public func mapToType<X: Decodable where X == X.DecodedType>(classType: X.Type) -> Signal<X, NSError> {
        return self.attemptMap { object -> Result<X, NSError> in
            let decoded: Decoded<X> = decode(object)
            
            switch decoded {
            case .Success(let value):
                return .Success(value)
            case .Failure(let error):
                return .Failure(ArgonautError(type: String(X), reason: error.description).nsError)
            }
        }
    }
    
    /// Maps the given JSON object array within the stream to an array of objects of the given classType
    ///
    /// - parameter classType: The type of the array that should be returned
    /// - returns: A new Signal emitting an array of decoded objects
    public func mapToTypeArray<X: Decodable where X == X.DecodedType>(classType: X.Type) -> Signal<[X], NSError> {
        return self.attemptMap { object -> Result<[X], NSError> in
            let decoded: Decoded<[X]> = decode(object)
            
            switch decoded {
            case .Success(let value):
                return .Success(value)
            case .Failure(let error):
                return .Failure(ArgonautError(type: "[\(String(X))]", reason: error.description).nsError)
            }
        }
    }
    
}

extension SignalProducerType where Value == AnyObject, Error == NSError {
    
    /// Maps the given JSON object within the stream to an object of given classType
    ///
    /// - parameter classType: The type of the object that should be returned
    /// - returns: A new Signal emitting the decoded object
    public func mapToType<X: Decodable where X == X.DecodedType>(classType: X.Type) -> SignalProducer<X, NSError> {
        return lift { $0.mapToType(classType) }
    }
    
    /// Maps the given JSON object array within the stream to an array of objects of the given classType
    ///
    /// - parameter classType: The type of the array that should be returned
    /// - returns: A new Signal emitting an array of decoded objects
    public func mapToTypeArray<X: Decodable where X == X.DecodedType>(classType: X.Type) -> SignalProducer<[X], NSError> {
        return lift { $0.mapToTypeArray(classType) }
    }
    
}
