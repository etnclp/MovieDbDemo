//
//  MovieDetailRequest.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

struct MovieDetailRequest: MovieDbAPI {

    typealias Response = MovieDetail

    var path: String
    var method: HTTPMethod = .get
    var parameters: [String : Any]? = [
        "language": ApiConstants.LANGUAGE,
        "api_key": ApiConstants.API_KEY
    ]

    init(id: Int) {
        path = "/3/movie/\(id)"
    }

}
