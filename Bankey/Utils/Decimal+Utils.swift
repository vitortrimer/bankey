//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Vitor Trimer on 06/06/22.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
