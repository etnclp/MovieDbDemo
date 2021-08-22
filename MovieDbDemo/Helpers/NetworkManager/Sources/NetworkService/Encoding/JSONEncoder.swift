//
//  JSONEncoder.swift
//  ERDNetwork
//
//  Created by Erdi Tunçalp on 13.04.2021.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {

    func encode(urlRequest: inout URLRequest, with parameters: Parameters?) throws {

        guard let parameters = parameters else { return }

        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
        } catch {
            throw EncodingError.encodingFailed
        }
    }

}
