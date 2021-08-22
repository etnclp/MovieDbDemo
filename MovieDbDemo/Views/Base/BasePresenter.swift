//
//  BasePresenter.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

protocol BasePresenter {
    associatedtype V
    var view: V? { get set }

    associatedtype R
    var router: R? { get set }
}
