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

public enum ArgonautError: ErrorType {
    case Decoding(type: String, reason: String)
    case Underlying(ErrorType)
    
    public var nsError: NSError {
        switch self {
        case let .Decoding(type, reason):
            let info = [NSLocalizedFailureReasonErrorKey: "\(type): \(reason)"]
            return NSError(domain: ArgonautErrorDomain, code: -1, userInfo: info)
        case let .Underlying(error):
            return error as NSError
        }
    }
}

/// Transforms a decoded object to a result or an Argomaut error
private func result<T>(decoded: Decoded<T>) -> Result<T, ArgonautError> {
    switch decoded {
    case .Success(let value):
        return .Success(value)
    case .Failure(let error):
        return .Failure(ArgonautError.Decoding(type: String(T), reason: error.description))
    }
}

extension SignalType where Value == AnyObject {

    /// Maps the given JSON object within the stream to an object of given classType
    ///
    /// - parameter classType: The type of the object that should be returned
    /// - returns: A new Signal emitting the decoded object
    public func mapToType<X: Decodable where X == X.DecodedType>(classType: X.Type) -> Signal<X, ArgonautError> {
        return mapError { ArgonautError.Underlying($0) }
            .attemptMap { object in
                let decoded: Decoded<X> = decode(object)
                return result(decoded)
            }
    }
    
    /// Maps the given JSON object array within the stream to an array of objects of the given classType
    ///
    /// - parameter classType: The type of the array that should be returned
    /// - returns: A new Signal emitting an array of decoded objects
    public func mapToTypeArray<X: Decodable where X == X.DecodedType>(classType: X.Type) -> Signal<[X], ArgonautError> {
        return mapError { ArgonautError.Underlying($0) }
            .attemptMap { object in
                let decoded: Decoded<[X]> = decode(object)
                return result(decoded)
            }
    }
    
}

extension SignalProducerType where Value == AnyObject {
    
    /// Maps the given JSON object within the stream to an object of given classType
    ///
    /// - parameter classType: The type of the object that should be returned
    /// - returns: A new Signal emitting the decoded object
    public func mapToType<X: Decodable where X == X.DecodedType>(classType: X.Type) -> SignalProducer<X, ArgonautError> {
        return lift { $0.mapToType(classType) }
    }
    
    /// Maps the given JSON object array within the stream to an array of objects of the given classType
    ///
    /// - parameter classType: The type of the array that should be returned
    /// - returns: A new Signal emitting an array of decoded objects
    public func mapToTypeArray<X: Decodable where X == X.DecodedType>(classType: X.Type) -> SignalProducer<[X], ArgonautError> {
        return lift { $0.mapToTypeArray(classType) }
    }
    
}

extension SignalType where Value == [String: AnyObject] {

    public func mapToType<X: Decodable where X == X.DecodedType>(classType: X.Type, rootKey: String) -> Signal<X, ArgonautError> {
        return mapError { ArgonautError.Underlying($0) }
            .attemptMap { object in
                let decoded: Decoded<X> = decode(object, rootKey: rootKey)
                return result(decoded)
            }
    }

    public func mapToTypeArray<X: Decodable where X == X.DecodedType>(classType: X.Type, rootKey: String) -> Signal<[X], ArgonautError> {
        return mapError { ArgonautError.Underlying($0) }
            .attemptMap { object in
                let decoded: Decoded<[X]> = decode(object, rootKey: rootKey)
                return result(decoded)
            }
    }

}

extension SignalProducerType where Value == [String: AnyObject] {

    public func mapToType<X: Decodable where X == X.DecodedType>(classType: X.Type, rootKey: String) -> SignalProducer<X, ArgonautError> {
        return lift { $0.mapToType(classType, rootKey: rootKey) }
    }

    public func mapToTypeArray<X: Decodable where X == X.DecodedType>(classType: X.Type, rootKey: String) -> SignalProducer<[X], ArgonautError> {
        return lift { $0.mapToTypeArray(classType, rootKey: rootKey) }
    }

}
