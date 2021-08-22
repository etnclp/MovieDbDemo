//
//  MovieDbAPI.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

protocol MovieDbAPI: Endpoint {}

extension MovieDbAPI {

    var api: API {
        return API(baseURL: BaseURL(scheme: "https", host: "api.themoviedb.org"))
    }

    var defaultHeaders: [String: String] {
        let customHeaders: [String: String] = ["Content-Type": contentType.rawValue]
        return HeaderBuilder(with: self).build(customHeaders: customHeaders)
    }

}
