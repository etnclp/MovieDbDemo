//
//  URLRequestConvertible.swift
//  ERDNetwork
//
//  Created by Erdi Tunçalp on 13.04.2021.
//

import Foundation

public protocol URLRequestConvertible {
    /// Returns a `URLRequest` or throws if an `Error` was encountered.
    ///
    /// - Returns: A `URLRequest`.
    /// - Throws:  Any error thrown while constructing the `URLRequest`.
    func asURLRequest() throws -> URLRequest
}
