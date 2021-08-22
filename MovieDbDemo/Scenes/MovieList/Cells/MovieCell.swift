//
//  MovieCell.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell, SpecialCell {
    
    // MARK: - Properties
    
    static var Size: CGSize = {
        let width: CGFloat = (UIScreen.main.bounds.width - 55)/2
        let height = width * 1.1823
        return .init(width: width, height: height)
    }()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var favoriteImageView: UIImageView!
    
    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.hex("#E7EAF0").cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 8)
        contentView.layer.shadowRadius = 6
        contentView.layer.shadowOpacity = 0.9
        contentView.clipsToBounds = true
    }

    // MARK: - Configure

    func configure(_ viewProtocol: MovieCellViewProtocol) {
        imageView.setImage(url: viewProtocol.imageUrl, placeholder: UIImage(systemName: "film"))
        titleLabel.text = viewProtocol.title
        favoriteImageView.isHidden = !viewProtocol.isFavorite
    }
    
}
