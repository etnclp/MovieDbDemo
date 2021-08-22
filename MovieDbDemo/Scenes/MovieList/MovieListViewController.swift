//
//  MovieListViewController.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import UIKit

protocol MovieListView: ViewInput {
    func reloadData()
}

class MovieListViewController: BaseViewController, BaseView {

    var presenter: MovieListViewOutput?
    var router: MovieListRouterInput?

    // MARK: - IBOutlets

    @IBOutlet weak private var collectionView: UICollectionView!

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        setupUI()
    }
    
    override func configureViper() {
        MovieListRouter.configure(self)
    }

    private func setupUI() {
        title = "Popular Movies"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = MovieCell.Size
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        flowLayout.minimumLineSpacing = 15
        flowLayout.minimumInteritemSpacing = 15
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.dataSource = self
        collectionView.delegate = self
        MovieCell.register(to: collectionView)
    }
    
}

extension MovieListViewController: MovieListView {

    func reloadData() {
        collectionView.isHidden = false
        collectionView.reloadData()
    }

}

// MARK: - UICollectionViewDataSource

extension MovieListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)

        if let viewModel = presenter?.viewModelForRow(index: indexPath.row) {
            cell.configure(viewModel)
        }

        return cell
    }

}

// MARK: - UICollectionViewDelegate

extension MovieListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        presenter?.didSelectItem(index: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == collectionView.numberOfSections - 1 &&
            indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            presenter?.nextPageAction()
        }
    }

}
