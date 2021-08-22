//
//  Environment.swift
//  ERDNetwork
//
//  Created by Erdi Tunçalp on 13.04.2021.
//

import Foundation

public struct Environment {
    public var type: EnvironmentType

    public init(type: EnvironmentType) {
        self.type = type
    }
}

public enum EnvironmentType: String {
    case debug = "Debug"
    case beta = "Beta"
    case prod = "Release"
}
