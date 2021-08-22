//
//  MovieDetail.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 20.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

struct MovieDetail: Codable {
    var runtime: Int?
    var status, backdropPath, overview, title: String?
    var voteCount: Int?
    var tagline: String?
    var originalTitle, originalLanguage, posterPath: String?
    var revenue: Int?
    var homepage: String?
    var video: Bool?
    var imdbID: String?
    var id: Int?
    var releaseDate: String?
    var budget: Int?
    var popularity: Double?
    var genres: [Genre]?
    var adult: Bool?
    var voteAverage: Double?

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
        case runtime, status
        case backdropPath = "backdrop_path"
        case overview, title
        case voteCount = "vote_count"
        case tagline
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case posterPath = "poster_path"
        case revenue, homepage, video
        case imdbID = "imdb_id"
        case id
        case releaseDate = "release_date"
        case budget, popularity, genres
        case adult
        case voteAverage = "vote_average"
    }
}

// MARK: - Genre
struct Genre: Codable {
    var id: Int?
    var name: String?
}
