//
//  JSONMapping+ReactiveCocoa.swift
//  Example
//
//  Created by Alexander Schuch on 03/04/15.
//  Copyright (c) 2015 Alexander Schuch. All rights reserved.
//

import Foundation
import Argo
import ReactiveSwift
import Result

public let ArgonautErrorDomain = "com.aschuch.Argonaut.ErrorDomain"

public enum ArgonautError: Error {
    case decoding(type: String, reason: String)
    case underlying(Error)
    
    public var nsError: NSError {
        switch self {
        case let .decoding(type, reason):
            let info = [NSLocalizedFailureReasonErrorKey: "\(type): \(reason)"]
            return NSError(domain: ArgonautErrorDomain, code: -1, userInfo: info)
        case let .underlying(error):
            return error as NSError
        }
    }
}

/// Transforms a decoded object to a result or an Argonaut error
private func result<T>(_ decoded: Decoded<T>) -> Result<T, ArgonautError> {
    switch decoded {
    case .success(let value):
        return .success(value)
    case .failure(let error):
        return .failure(ArgonautError.decoding(type: String(describing: T.self), reason: error.description))
    }
}

extension SignalProtocol where Value == Any {

    /// Maps the given JSON object within the stream to an object of given classType
    ///
    /// - parameter classType: The type of the object that should be returned
    /// - returns: A new Signal emitting the decoded object
    public func mapToType<X: Decodable>(_ classType: X.Type, rootKey: String? = nil) -> Signal<X, ArgonautError> where X == X.DecodedType {
        return mapError { ArgonautError.underlying($0) }
            .attemptMap { object in
                let decoded: Decoded<X>
                if let rootKey = rootKey, let object = object as? [String: Any] {
                    decoded = decode(object, rootKey: rootKey)
                } else {
                    decoded = decode(object)
                }

                return result(decoded)
            }
    }
    
    /// Maps the given JSON object array within the stream to an array of objects of the given classType
    ///
    /// - parameter classType: The type of the array that should be returned
    /// - returns: A new Signal emitting an array of decoded objects
    public func mapToTypeArray<X: Decodable>(_ classType: X.Type, rootKey: String? = nil) -> Signal<[X], ArgonautError> where X == X.DecodedType {
        return mapError { ArgonautError.underlying($0) }
            .attemptMap { object in
                let decoded: Decoded<[X]>
                if let rootKey = rootKey, let object = object as? [String: Any] {
                    decoded = decode(object, rootKey: rootKey)
                } else {
                    decoded = decode(object)
                }
                return result(decoded)
            }
    }
    
}

extension SignalProducerProtocol where Value == Any {
    
    /// Maps the given JSON object within the stream to an object of given classType
    ///
    /// - parameter classType: The type of the object that should be returned
    /// - returns: A new Signal emitting the decoded object
    public func mapToType<X: Decodable>(_ classType: X.Type, rootKey: String? = nil) -> SignalProducer<X, ArgonautError> where X == X.DecodedType {
        return lift { $0.mapToType(classType, rootKey: rootKey) }
    }
    
    /// Maps the given JSON object array within the stream to an array of objects of the given classType
    ///
    /// - parameter classType: The type of the array that should be returned
    /// - returns: A new Signal emitting an array of decoded objects
    public func mapToTypeArray<X: Decodable>(_ classType: X.Type, rootKey: String? = nil) -> SignalProducer<[X], ArgonautError> where X == X.DecodedType {
        return lift { $0.mapToTypeArray(classType, rootKey: rootKey) }
    }
    
}
