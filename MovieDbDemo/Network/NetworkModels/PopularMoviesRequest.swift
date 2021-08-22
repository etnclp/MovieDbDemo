//
//  PopularMoviesRequest.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

struct PopularMoviesRequest: MovieDbAPI {

    typealias Response = BaseResponse<[Movie]>

    var path: String = "/3/movie/popular"
    var method: HTTPMethod = .get
    var parameters: [String : Any]?

    init(page: Int) {
        parameters = [
            "language": ApiConstants.LANGUAGE,
            "api_key": ApiConstants.API_KEY,
            "page": page
        ]
    }

}
