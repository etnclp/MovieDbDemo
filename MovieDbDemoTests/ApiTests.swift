//
//  ApiTests.swift
//  MovieDbDemoTests
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import XCTest
@testable import MovieDbDemo

class ApiTests: XCTestCase {

    func testPopularMoviesApi() {
        var resultCount = 0
        let expectation = self.expectation(description: "PopularMoviesApi")
        let request = PopularMoviesRequest(page: 1)
        NetworkManager.shared.execute(request: request) { response in
            expectation.fulfill()
            switch response.result {
            case .success(let result):
                resultCount = result.results.count
            case .failure(let error):
                print(error)
                XCTFail("Fail \(error)")
            }
        }

        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertEqual(resultCount, 20)
    }

    func testMovieDetailApi() {
        var resultTitle = ""
        let expectation = self.expectation(description: "MovieDetailApi")
        let request = MovieDetailRequest(id: 436969)
        NetworkManager.shared.execute(request: request) { response in
            expectation.fulfill()
            switch response.result {
            case .success(let result):
                if let title = result.title {
                    resultTitle = title
                }
            case .failure(let error):
                print(error)
                XCTFail("Fail \(error)")
            }
        }

        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertEqual(resultTitle, "The Suicide Squad")
    }

}
