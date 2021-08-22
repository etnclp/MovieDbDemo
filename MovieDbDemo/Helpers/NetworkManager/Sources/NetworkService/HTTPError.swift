//
//  HTTPError.swift
//  ERDNetwork
//
//  Created by Erdi Tunçalp on 13.04.2021.
//

import Foundation

public enum HTTPError: Error {
    case undefined(data: Data?)
    case authentication(data: Data?)
    case badRequest(data: Data?)
    case notFound(data: Data?)
    case internalError(data: Data?)
    case noData(data: Data?)
    case connection(data: Data?)
    case unableToDecode(data: Data?)
    case nilData(data: Data?)
    case requestCannotBeBuilt(data: Data?)
    case tooManyRequest(data: Data?)
    case forbidden(data: Data?)
}

extension HTTPError: LocalizedError {

    public var rawValue: String? {
        switch self {
        case .undefined(_): return "undefined"
        case .authentication(_): return "authentication"
        case .badRequest(_): return "badRequest"
        case .notFound(_): return "notFound"
        case .internalError(_): return "internalError"
        case .noData(_): return "noData"
        case .connection(_): return "connection"
        case .unableToDecode(_): return "unableToDecode"
        case .nilData(_): return "nilData"
        case .requestCannotBeBuilt(_): return "requestCannotBeBuilt"
        case .tooManyRequest(_): return "tooManyRequest"
        case .forbidden(_): return "forbidden"
        }
    }

    public var code: Int? {
        switch self {
        case .authentication(_): return 412
        case .badRequest(_): return 400
        case .forbidden(_): return 403
        case .notFound(_): return 404
        case .internalError(_): return 500
        case .tooManyRequest(_): return 429
        default:
            return nil
        }
    }

    public var type: String? {
        switch self {
        case .authentication(let data),
             .badRequest(let data),
             .notFound(let data),
             .internalError(let data),
             .forbidden(let data),
             .noData(let data),
             .connection(let data),
             .unableToDecode(let data),
             .requestCannotBeBuilt(let data),
             .tooManyRequest(let data),
             .undefined(let data):
            return data?.format()?.type
        default:
            return nil
        }
    }

    public var errorDescription: String? {
        switch self {
        case .authentication(let data):
            return data?.format()?.finalMessage ?? "authentication"
        case .badRequest(let data):
            return data?.format()?.finalMessage ?? "badRequest"
        case .notFound(let data):
            return data?.format()?.finalMessage ?? "notFound"
        case .internalError(let data):
            return data?.format()?.finalMessage ?? "internalError"
        case .noData(let data):
            return data?.format()?.finalMessage ?? "noData"
        case .connection(let data):
            return data?.format()?.finalMessage ?? "connection"
        case .unableToDecode(let data):
            return data?.format()?.finalMessage ?? "unableToDecode"
        case .requestCannotBeBuilt(let data):
            return data?.format()?.finalMessage ?? "requestCannotBeBuilt"
        case .tooManyRequest(let data):
            return data?.format()?.finalMessage ?? "occuredAndTryAgain"
        case .undefined(let data):
            return data?.format()?.finalMessage ?? "undefined"
        default:
            return "unknown"
        }
    }

}

private extension Data {
    func format() -> ErrorBody? {
        return try? JSONDecoder().decode(ErrorBody?.self, from: self)
    }
}

public struct ErrorBody: Codable {

    public let type: String?
    public let error: String?

    enum CodingKeys: String, CodingKey {
        case type
        case error
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try? container.decode(String?.self, forKey: .type)
        self.error = try? container.decode(String?.self, forKey: .error)
    }

    var finalMessage: String? {
        guard let message = error else { return nil }
        return message
    }

}
