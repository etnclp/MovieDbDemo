//
//  MovieDetailPresenter.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

protocol MovieDetailViewOutput {
    var movieId: Int? { get set }
    var favoriteUpdated: ((Bool) -> Void)? { get set }
    var isFavorite: Bool { get set }

    func viewDidLoad()
}

class MovieDetailPresenter: BasePresenter {

    typealias V = MovieDetailView
    typealias I = AnyObject
    typealias R = MovieDetailRouterInput

    weak var view: V?
    var interactor: I?
    var router: R?

    private var movieDetail: MovieDetail? {
        didSet {
            view?.updateComponents(movieDetail)
        }
    }
    private let manager = CoreDataManager<FavoriteStatus>()
    private lazy var favoriteStatus = try? manager.getItem(NSPredicate(format: "id == %d", movieId ?? 0)).first

    var movieId: Int?
    var favoriteUpdated: ((Bool) -> Void)?
    var isFavorite: Bool {
        get {
            favoriteStatus?.isStatus ?? false
        }
        set {
            favoriteUpdated?(newValue)
            if let favStatus = self.favoriteStatus {
                favStatus.isStatus = newValue
                try? manager.update(item: favStatus)
            } else {
                try? manager.addItem { status in
                    status.id = NSNumber(integerLiteral: movieId ?? 0)
                    status.isStatus = newValue
                    favoriteStatus = status
                }
            }
        }
    }

    func fetchMovieDetail() {
        guard let movieId = movieId else { return }
        self.view?.showIndicator()
        let request = MovieDetailRequest(id: movieId)
        NetworkManager.shared.execute(request: request) { [weak self] response in
            guard let self = self else { return }
            self.view?.hideIndicator()
            switch response.result {
            case .success(let result):
                self.movieDetail = result
            case .failure(let error):
                log.error(error)
                self.view?.showAlert(message: error.localizedDescription)
            }
        }
    }
    
}

extension MovieDetailPresenter: MovieDetailViewOutput {

    func viewDidLoad() {
        fetchMovieDetail()
    }

}
