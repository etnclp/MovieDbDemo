//
//  BaseView.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import UIKit

protocol ViewInput where Self: UIViewController {
    func showErrorMessage(error: NSError)
    func showAlert(message: String, title: String?, showCancel: Bool, completion: (() -> Void)?)
    func showIndicator(message: String?)
    func hideIndicator()
}

protocol ViewOutput: AnyObject {

}

extension ViewInput {

    func showErrorMessage(error: NSError) {
        self.showAlert(message: error.localizedDescription)
    }

    func showAlert(message: String, title: String? = "Error", showCancel: Bool = false, completion: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            completion?()
        }))
        if showCancel == true {
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        }
        DispatchQueue.main.async {
            guard !(self.presentedViewController is UIAlertController) else { return }
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    func showIndicator(message: String? = nil) {
        let progressView = UIView(frame: UIScreen.main.bounds)
        progressView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        progressView.tag = 10
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.center = progressView.center
        indicator.startAnimating()
        progressView.addSubview(indicator)

        navigationController?.view.addSubview(progressView)
    }

    func hideIndicator() {
        let progress = navigationController?.view.subviews.filter({ $0.tag == 10 }).first
        progress?.removeFromSuperview()
    }
    
}

protocol BaseView: ViewInput {
    associatedtype P
    var presenter: P? { get set }
    associatedtype R
    var router: R? { get set }
}
