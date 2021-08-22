//
//  DateFormatter+Extensions.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    func setDateFormat(_ dateFormat: String) -> DateFormatter {
        self.dateFormat = dateFormat
        return self
    }
    
}
