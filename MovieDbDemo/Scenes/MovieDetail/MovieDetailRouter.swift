//
//  MovieDetailRouter.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import UIKit

protocol MovieDetailRouterInput: RouterInput {
    
}

class MovieDetailRouter: BaseRouter {
    
    typealias VC = MovieDetailViewController
    weak var viewController: VC?
    
    struct Segues {
    }
    
    class func configure(_ viewController: MovieDetailViewController) {
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter()
        
        viewController.router = router
        router.viewController = viewController
        presenter.router = router
        presenter.view = viewController
        viewController.presenter = presenter
    }
    
}

extension MovieDetailRouter: MovieDetailRouterInput {
    
}
