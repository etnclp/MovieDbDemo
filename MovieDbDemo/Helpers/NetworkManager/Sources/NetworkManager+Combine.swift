//
//  NetworkManager+Combine.swift
//  ERDNetwork
//
//  Created by Erdi Tunçalp on 13.04.2021.
//

#if canImport(Combine)
import Combine
import Foundation

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension NetworkManager {
    
    public func execute<T: Endpoint>(request: T) -> AnyPublisher<T.Response, NetworkingError> {
        let urlRequest: URLRequest
        do {
            urlRequest = try request.asURLRequest()
        } catch {
            return Fail(error: .parameterEncodingFailed(reason: .jsonEncodingFailed(error: error)))
                .eraseToAnyPublisher()
        }
        
        if isLogEnabled {
            print(urlRequest.curlString)
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                if self.isLogEnabled {
                    print("Response: \(data.prettyPrint) - Status Code: \(response.httpStatusCode)")
                }
                
                guard 200..<300 ~= response.httpStatusCode else {
                    throw NetworkingError.connectionError(response.filterStatusCode(with: data))
                }
                return (data, response)
            }
            .decoder(type: T.Response.self, decoder: JSONDecoder())
            .mapError { (($0 as? DecodingError) != nil) ? .decodingFailed($0 as! DecodingError) : .undefined }
            .eraseToAnyPublisher()
    }
    
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Publisher {
    
    fileprivate func decoder<Item>(type: Item.Type, decoder: JSONDecoder) -> Publishers.TryMap<Self, Item> where Item : Decodable, Self.Output == URLSession.DataTaskPublisher.Output {
        if Item.self == String.self || Item.self == Optional<String>.self {
            return tryMap { String(data: $0.data, encoding: .utf8) as! Item }
        }
        
        return tryMap { try decoder.decode(type, from: $0.data) }
    }
    
}
#endif
