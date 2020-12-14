//
//  NumberFormatter+Ext.swift
//  SwiftUI_PFinance
//
//  Created by Stanly Shiyanovskiy on 01.12.2020.
//

import Foundation

extension NumberFormatter {
    static func currency(from value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let formattedValue = formatter.string(from: NSNumber(value: value)) ?? ""
        
        return "$" + formattedValue
    }
}
