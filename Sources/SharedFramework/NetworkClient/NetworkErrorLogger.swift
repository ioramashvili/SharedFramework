//
//  NetworkErrorLogger.swift
//
//
//  Copyright © 2020 Adjarabet. All rights reserved.
//

import Foundation
import OSLog

/// This extension enhances the `Logger` class with a networking-specific logger.
///
/// It provides a convenient way to log networking-related messages using a dedicated logger
/// with a specific subsystem and category. The subsystem is derived from the main bundle's
/// identifier, and the category is set to "Networking".
extension Logger {
    /// A static networking logger instance.
    ///
    /// This logger is configured with the main bundle's identifier as the subsystem and
    /// "Networking" as the category. If the bundle identifier is not available, an empty
    /// string is used as the subsystem.
    static let networking = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "Networking")
}

/// A protocol defining the interface for logging network errors.
public protocol NetworkErrorLogger {
    /// Logs a request.
    ///
    /// - Parameter request: The `URLRequest` object to be logged.
    func log(request: URLRequest)

    /// Logs response data and response headers.
    ///
    /// - Parameters:
    ///   - data: The response data to be logged.
    ///   - response: The `URLResponse` object containing response header fields.
    func log(responseData data: Data?, response: URLResponse?)

    /// Logs an error.
    ///
    /// - Parameter error: The `Error` object to be logged.
    func log(error: Error)

    /// Logs a status code.
    ///
    /// - Parameter statusCode: The HTTP status code to be logged.
    func log(statusCode: Int)
}

/// A default implementation of the `NetworkErrorLogger` protocol.
public final class DefaultNetworkErrorLogger {
    /// The shared instance of the `DefaultNetworkErrorLogger` class.
    public static let shared = DefaultNetworkErrorLogger()

    /// Initializes a new instance of the `DefaultNetworkErrorLogger` class.
    public init() { }
}

extension DefaultNetworkErrorLogger: NetworkErrorLogger {
    public func log(request: URLRequest) {
        let body = if let httpBody = request.httpBody, let result = ((try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: AnyObject]) as [String: AnyObject]??) {
            "body: \(String(describing: result))"
        } else if let httpBody = request.httpBody, let resultString = String(data: httpBody, encoding: .utf8) {
            "body: \(String(describing: resultString))"
        } else {
            ""
        }

        Logger.networking.debug("""

        "-------------"
        "request: \(request.url?.absoluteString ?? "")"
        "headers: \(request.allHTTPHeaderFields ?? [:])"
        "method: \(request.httpMethod ?? "")"
        "body: \(body)"
        "-------------"

        """)
    }

    public func log(responseData data: Data?, response: URLResponse?) {
        let headerFields = (response as? HTTPURLResponse)?.allHeaderFields ?? [:]

        Logger.networking.debug("headerFields: \(headerFields)")

        guard let data, let responseData = String(data: data, encoding: .utf8) else {
            return
        }

        Logger.networking.debug("responseData: \(responseData)")
    }

    public func log(error: Error) {
        switch error {
        case DecodingError.dataCorrupted(let context):
            Logger.networking.debug("\(context.debugDescription)")
        case let DecodingError.keyNotFound(key, context):
            Logger.networking.debug("Key '\(key.description)' not found: \(context.debugDescription)")
            Logger.networking.debug("codingPath: \(context.codingPath)")
        case let DecodingError.valueNotFound(value, context):
            Logger.networking.debug("Value '\(value)' not found: \(context.debugDescription)")
            Logger.networking.debug("codingPath: \(context.codingPath)")
        case let DecodingError.typeMismatch(type, context):
            Logger.networking.debug("Type '\(type)' mismatch: \(context.debugDescription)")
            Logger.networking.debug("codingPath: \(context.codingPath)")
        default:
            Logger.networking.debug("error: \(error)")
        }
    }

    public func log(statusCode: Int) {
        Logger.networking.debug("status code: \(statusCode)")
    }
}

