//
//  DataFormatterExtension.swift
//  zaffaripoc
//
//  Created by Companhia Zaffari on 31/07/2019.
//  Copyright © 2019 Companhia Zaffari. All rights reserved.
//

import Foundation
extension Formatter {
    static let ZaffariDataFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
