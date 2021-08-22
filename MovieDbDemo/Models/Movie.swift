//
//  Movie.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var adult: Bool?
    var backdropPath: String?
    var genreIDS: [Int]?
    var id: Int?
    var originalLanguage: String?
    var originalTitle, overview: String?
    var popularity: Double?
    var posterPath, releaseDate, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?

    var posterImageUrl: String? {
        guard let path = posterPath else { return nil }
        return "https://image.tmdb.org/t/p/w200/" + path
    }

    var backdropImageUrl: String? {
        guard let path = backdropPath else { return nil }
        return "https://image.tmdb.org/t/p/w500/" + path
    }

    var year: String? {
        let formatter = DateFormatter().setDateFormat("yyyy-MM-dd")
        guard let date = self.releaseDate, let year = formatter.date(from: date) else { return nil }
        return formatter.setDateFormat("yyyy").string(from: year)
    }

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
