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
import LlamaKit

public let ArgonautErrorDomain = "com.aschuch.Argonaut.ErrorDomain"

public struct ArgonautError: ErrorType {
    let reason: String
    
    public var nsError: NSError {
        return NSError(domain: ArgonautErrorDomain, code: -1, userInfo: [NSLocalizedFailureReasonErrorKey: reason])
    }
}

// MARK: ReactiveCocoa <= 2.x

extension RACSignal {
    
    /// Maps the given JSON object (AnyObject) to an object of given classType
    ///
    /// :param: classType The type of the object that should be returned
    /// :returns: A new RACSignal emitting the decoded object
    public func mapToType<T: protocol<NSObjectProtocol, Decodable> where T == T.DecodedType>(classType: T.Type) -> RACSignal {
        return tryMap { (object, error) -> T! in
            let decoded: Decoded<T> = decode(object)
            
            switch decoded {
            case .Success(let box):
                return box.value
            case .TypeMismatch(let reason):
                if error != nil {
                    error.memory = NSError(domain: ArgonautErrorDomain, code: -100, userInfo: [NSLocalizedFailureReasonErrorKey: reason])
                }
                return nil
            case .MissingKey(let reason):
                if error != nil {
                    error.memory = NSError(domain: ArgonautErrorDomain, code: -200, userInfo: [NSLocalizedFailureReasonErrorKey: reason])
                }
                return nil
            }
        }
    }
    
    
    /// Maps the given JSON object array to an array of objects of the given classType
    ///
    /// :param: classType The type of the array that should be returned
    /// :returns: A new RACSignal emitting an array of decoded objects
    public func mapToTypeArray<T: protocol<NSObjectProtocol, Decodable> where T == T.DecodedType>(classType: T.Type) -> RACSignal {
        return tryMap { (object, error) -> AnyObject! in
            let decoded: Decoded<[T]> = decode(object)
            
            switch decoded {
            case .Success(let box):
                return box.value
            case .TypeMismatch(let reason):
                if error != nil {
                    error.memory = NSError(domain: ArgonautErrorDomain, code: -100, userInfo: [NSLocalizedFailureReasonErrorKey: reason])
                }
                return nil
            case .MissingKey(let reason):
                if error != nil {
                    error.memory = NSError(domain: ArgonautErrorDomain, code: -200, userInfo: [NSLocalizedFailureReasonErrorKey: reason])
                }
                return nil
            }
        }
    }
    
}


// MARK: ReactiveCocoa >= 3.x
    
public func mapToType<T: Decodable where T == T.DecodedType>(classType: T.Type)(signal: Signal<AnyObject, NSError>) -> Signal<T, NSError> {
    return signal |> tryMap { object in
        let decoded: Decoded<T> = decode(object)
        
        switch decoded {
        case .Success(let box):
            return success(box.value)
        case .TypeMismatch(let reason):
            return failure(ArgonautError(reason: reason).nsError)
        case .MissingKey(let reason):
            return failure(ArgonautError(reason: reason).nsError)
        }
    }
}

public func mapToType<T: Decodable where T == T.DecodedType>(classType: T.Type)(signal: Signal<AnyObject, NSError>) -> Signal<[T], NSError> {
    return signal |> tryMap { object in
        let decoded: Decoded<[T]> = decode(object)
        
        switch decoded {
        case .Success(let box):
            return success(box.value)
        case .TypeMismatch(let reason):
            return failure(ArgonautError(reason: reason).nsError)
        case .MissingKey(let reason):
            return failure(ArgonautError(reason: reason).nsError)
        }
    }
}
