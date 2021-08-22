//
//  Data+PrettyPrint.swift
//  ERDNetwork
//
//  Created by Erdi Tunçalp on 13.04.2021.
//

import Foundation

extension Data {
    
    var prettyPrint: String {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            return String(decoding: jsonData, as: UTF8.self)
        } else {
            return String(decoding: self, as: UTF8.self)
        }
    }
    
}
