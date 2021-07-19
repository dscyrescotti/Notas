//
//  Date+.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import Foundation

extension Date {
    var toString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, YYYY"
        return formatter.string(from: self)
    }
}
