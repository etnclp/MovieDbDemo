//
//  MovieListRouter.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import UIKit

protocol MovieListRouterInput: RouterInput {
    func routeToMovieDetail(id: Int)
}

class MovieListRouter: BaseRouter {
    
    weak var viewController: MovieListViewController?
    
    class func configure(_ viewController: MovieListViewController) {
        let router = MovieListRouter()
        let presenter = MovieListPresenter()
        
        viewController.router = router
        router.viewController = viewController
        presenter.router = router
        presenter.view = viewController
        viewController.presenter = presenter
    }
    
}

extension MovieListRouter: MovieListRouterInput {

    func routeToMovieDetail(id: Int) {
        let vc = MovieDetailViewController()
        vc.presenter?.movieId = id
        vc.presenter?.favoriteUpdated = { [weak self] status in
            self?.viewController?.reloadData()
        }
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

}
