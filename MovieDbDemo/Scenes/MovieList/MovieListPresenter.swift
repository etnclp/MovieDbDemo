//
//  MovieListPresenter.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

protocol MovieListViewOutput {
    func viewDidLoad()
    func numberOfItems() -> Int
    func viewModelForRow(index: Int) -> MovieCellViewProtocol?
    func didSelectItem(index: Int)
    func nextPageAction()
}

class MovieListPresenter: BasePresenter {

    weak var view: MovieListView?
    var router: MovieListRouterInput?

    private var currentPage = 1
    private var lastPage = 5
    private var nextPage: Int? {
        guard currentPage < lastPage else { return nil }
        return currentPage + 1
    }
    private var movieList: [Movie] = [] {
        didSet {
            view?.reloadData()
        }
    }
    private let manager = CoreDataManager<FavoriteStatus>()

    // MARK: - Actions

    private func fetchMovies(page: Int = 1) {
        view?.showIndicator()
        let request = PopularMoviesRequest(page: page)
        NetworkManager.shared.execute(request: request) { [weak self] response in
            guard let self = self else { return }
            self.view?.hideIndicator()
            switch response.result {
            case .success(let result):
                self.currentPage = result.page
                self.lastPage = result.totalPages
                if page == 1 {
                    self.movieList = result.results
                } else {
                    self.movieList += result.results
                }
            case .failure(let error):
                log.error(error)
                self.view?.showAlert(message: error.localizedDescription)
            }
        }
    }

    private func getFavoriteStatus(movieId: Int) -> Bool {
        return (try? manager.getItem(NSPredicate(format: "id == %d", movieId)).first?.isStatus) ?? false
    }

}

extension MovieListPresenter: MovieListViewOutput {

    func viewDidLoad() {
        fetchMovies()
    }

    func numberOfItems() -> Int {
        return movieList.count
    }

    func viewModelForRow(index: Int) -> MovieCellViewProtocol? {
        let movie = movieList[index]
        var isFavorite: Bool = false
        if let id = movie.id {
            isFavorite = getFavoriteStatus(movieId: id)
        }
        return MovieCellViewModel(movie: movie, isFavorite: isFavorite)
    }

    func didSelectItem(index: Int) {
        if let id = movieList[index].id {
            router?.routeToMovieDetail(id: id)
        } else {
            log.error("error")
        }
    }

    func nextPageAction() {
        guard let next = self.nextPage else { return }
        fetchMovies(page: next)
    }

}
