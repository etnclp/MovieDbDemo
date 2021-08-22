//
//  MovieDetailViewController.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import UIKit

protocol MovieDetailView: ViewInput {
    func updateComponents(_ movieDetail: MovieDetail?)
}

class MovieDetailViewController: BaseViewController, BaseView {
    
    typealias P = MovieDetailViewOutput
    typealias R = MovieDetailRouterInput
    
    var presenter: P?
    var router: R?

    private var favIcon: UIImage? {
        UIImage(systemName: (presenter?.isFavorite == true) ? "star.fill" : "star")
    }

    // MARK: - IBOutlets

    @IBOutlet weak private var movieImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var yearLabel: UILabel!
    @IBOutlet weak private var overviewTextView: UITextView!
    @IBOutlet weak private var voteCountLabel: UILabel!

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        setupUI()
    }
    
    override func configureViper() {
        MovieDetailRouter.configure(self)
    }

    private func setupUI() {
        view.subviews.forEach({ $0.isHidden = true })
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: favIcon, style: .done, target: self, action: #selector(favoriteButtonTapped))
    }

    // MARK: - Actions

    @objc private func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        presenter?.isFavorite.toggle()
        navigationItem.rightBarButtonItem?.image = favIcon
    }

}

extension MovieDetailViewController: MovieDetailView {

    func updateComponents(_ movieDetail: MovieDetail?) {
        movieImageView.contentMode = .scaleToFill
        movieImageView.setImage(url: movieDetail?.backdropImageUrl ?? movieDetail?.posterImageUrl, placeholder: UIImage(systemName: "film"))
        titleLabel.text = movieDetail?.title
        yearLabel.text = movieDetail?.year
        overviewTextView.text = movieDetail?.overview
        voteCountLabel.text = "\(movieDetail?.voteCount ?? 0)"
        view.subviews.forEach({ $0.isHidden = false })
    }

}
