//
//  SpecialCell.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation
import UIKit

public protocol SpecialCell: AnyObject {

    static var Identifier: String { get set }

    static var Nib: UINib { get }

    static var Height: CGFloat { get set }

    static var EstimatedHeight: CGFloat { get set }

    static var Size: CGSize { get set }

    static func register(to tableView: UITableView) -> Void

    static func register(to collectionView: UICollectionView) -> Void

}

public extension SpecialCell where Self: UITableViewCell {

    static var Identifier: String {
        get { return String(describing: self).lowercaseFirstLetter() }
        set { Identifier = newValue }
    }

    static var Nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }

    static var EstimatedHeight: CGFloat {
        get { return UITableView.automaticDimension }
        set { EstimatedHeight = newValue }
    }

    static var Size: CGSize {
        get { return CGSize(width: 0, height: 0)  }
        set { }
    }

    static func register(to tableView: UITableView) {
        tableView.register(self)
    }

    static func register(to collectionView: UICollectionView) {}

}

public extension SpecialCell where Self: UICollectionViewCell {

    static var Identifier: String {
        get { return String(describing: self).lowercaseFirstLetter() }
        set { Identifier = newValue }
    }

    static var Nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }

    static var Height: CGFloat {
        get { return 0 }
        set {  }
    }

    static var EstimatedHeight: CGFloat {
        get { return 0 }
        set {  }
    }

    static func register(to tableView: UITableView) {}

    static func register(to collectionView: UICollectionView) {
        collectionView.register(self)
    }

}

extension String {

    func lowercaseFirstLetter() -> String {
        return prefix(1).lowercased() + dropFirst()
    }

}

extension UITableView {

    func register<T: UITableViewCell>(_: T.Type) where T: SpecialCell {
        register(T.Nib, forCellReuseIdentifier: T.Identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: SpecialCell {
        guard let cell = dequeueReusableCell(withIdentifier: T.Identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.Identifier)")
        }

        return cell
    }

}

extension UICollectionView {

    func register<T: UICollectionViewCell>(_: T.Type) where T: SpecialCell {
        register(T.Nib, forCellWithReuseIdentifier: T.Identifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: SpecialCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.Identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.Identifier)")
        }

        return cell
    }

}
