//
//  NetworkManager.swift
//  ERDNetwork
//
//  Created by Erdi Tunçalp on 13.04.2021.
//

import Foundation

/// Singleton for all network operations.
public final class NetworkManager {

    public var isLogEnabled = false

    public static let shared = NetworkManager()

    private init() {}

    // MARK: - Public functions

    @discardableResult
    public func execute<Request: Endpoint>(request: Request, completion: ((Response<Request.Response>) -> Void)?) -> URLSessionTask? {
        let urlRequest: URLRequest
        do {
            urlRequest = try request.asURLRequest()
        } catch {
            completion?(
                Response<Request.Response>(
                    request: nil,
                    response: nil,
                    data: nil,
                    result: .failure(.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error)))
                )
            )
            return nil
        }

        if isLogEnabled {
            print(urlRequest.curlString)
        }

        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            var result: Result<Request.Response, NetworkingError>

            if let data = data, let response = response {
                result = self.decode((data, response))
            } else {
                let httpError = response?.filterStatusCode(with: data) ?? .undefined(data: data)
                result = .failure(.connectionError(httpError))
            }

            DispatchQueue.main.async {
                completion?(
                    Response<Request.Response>(
                        request: urlRequest,
                        response: response as? HTTPURLResponse,
                        data: data,
                        result: result
                    )
                )
            }
        })
        
        task.resume()
        return task
    }
    
    private func decode<T: Decodable>(_ pair: (data: Data, response: URLResponse)) -> Result<T, NetworkingError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        if isLogEnabled {
            print("Response: \(pair.data.prettyPrint) - Status Code: \(pair.response.httpStatusCode)")
        }

        guard 200..<300 ~= pair.response.httpStatusCode else {
            return .failure(.connectionError(pair.response.filterStatusCode(with: pair.data)))
        }

        do {
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: pair.data)
            return .success(object)
        } catch let error as DecodingError {
            return .failure(.decodingFailed(error))
        } catch {
            return .failure(.undefined)
        }
    }

}

extension URLResponse {

    var httpStatusCode: Int {
        return (self as? HTTPURLResponse)?.statusCode ?? 0
    }

    func filterSuccessData(with data: Data?) throws -> Data {
        if let responseData = data {
            return responseData
        } else {
            throw HTTPError.noData(data: nil)
        }
    }

    func filterStatusCode(with data: Data?) -> HTTPError {
        switch self.httpStatusCode {
        case 400: return .badRequest(data: data)
        case 412: return .authentication(data: data)
        case 403: return .forbidden(data: data)
        case 404: return .notFound(data: data)
        case 429: return .tooManyRequest(data: data)
        case 500: return .internalError(data: data)
        default: return .undefined(data: data)
        }
    }

}
