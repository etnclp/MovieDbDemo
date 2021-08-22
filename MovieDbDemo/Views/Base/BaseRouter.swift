//
//  BaseRouter.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import UIKit

protocol RouterInput {
    func back()
    func back(animated: Bool)
    func dismiss()
    func dismiss(animated: Bool)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

extension RouterInput where Self: BaseRouter {

    func back() {
        self.back(animated: true)
    }

    func back(animated: Bool = true) {
        viewController?.navigationController?.popViewController(animated: animated)
    }

    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }

    func dismiss(animated: Bool) {
        self.dismiss(animated: animated, completion: nil)
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        viewController?.dismiss(animated: true, completion: completion)
    }

}

protocol BaseRouter: RouterInput {
    associatedtype VC: UIViewController
    var viewController: VC? { get set }
    static func configure(_ viewController: VC)
}
