//
//  UIImage+Extensions.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import UIKit

extension UIImageView {

    private static var taskKey = 0
    private static var urlKey = 0

    private var currentTask: URLSessionTask? {
        get { return objc_getAssociatedObject(self, &UIImageView.taskKey) as? URLSessionTask }
        set { objc_setAssociatedObject(self, &UIImageView.taskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    private var currentURL: URL? {
        get { return objc_getAssociatedObject(self, &UIImageView.urlKey) as? URL }
        set { objc_setAssociatedObject(self, &UIImageView.urlKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func setImage(url urlString: String?, placeholder: UIImage?) {
        weak var oldTask = currentTask
        currentTask = nil
        oldTask?.cancel()

        self.image = nil

        guard let urlString = urlString, let url = URL(string: urlString) else { return }

        currentURL = url
        let spinner = UIActivityIndicatorView()
        spinner.center = center
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        self.addSubview(spinner)

        currentTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            self?.currentTask = nil
            DispatchQueue.main.async {
                spinner.removeFromSuperview()

                guard let data = data, let downloadedImage = UIImage(data: data) else {
                    if let error = error {
                        log.error(error)
                    }
                    self?.image = placeholder
                    return
                }

                self?.image = (url == self?.currentURL) ? downloadedImage : placeholder
            }
        }
        currentTask?.resume()
    }

}
