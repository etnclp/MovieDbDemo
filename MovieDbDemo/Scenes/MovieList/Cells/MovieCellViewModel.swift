//
//  MovieCellViewModel.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

protocol MovieCellViewProtocol {
    var title: String? { get }
    var imageUrl: String? { get }
    var isFavorite: Bool { get }
}

class MovieCellViewModel: MovieCellViewProtocol {

    var title: String?
    var imageUrl: String?
    var isFavorite: Bool

    init(movie: Movie?, isFavorite: Bool) {
        self.title = movie?.title
        self.imageUrl = movie?.posterImageUrl
        self.isFavorite = isFavorite
    }

}
