//
//  FavoriteStatus.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 22.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import CoreData

@objc(FavoriteStatus)
class FavoriteStatus: NSManagedObject {

    var isStatus: Bool {
        get { Bool(truncating: status ?? 0) }
        set { status = NSNumber(value: newValue) }
    }

}

extension FavoriteStatus {

    @NSManaged var id: NSNumber?
    @NSManaged var status: NSNumber?
}
