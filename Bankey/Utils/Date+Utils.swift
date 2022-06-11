//
//  Date+Utils.swift
//  Bankey
//
//  Created by Vitor Trimer on 11/06/22.
//

import Foundation


extension Date {
    static var bankeyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "MDT")
        return formatter
    }
    
    var dayMonthYearString: String {
        let dateFormatter = Date.bankeyDateFormatter
        dateFormatter.dateFormat = "d, MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
