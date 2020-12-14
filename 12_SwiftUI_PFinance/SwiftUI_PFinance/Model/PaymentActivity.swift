//
//  PaymentActivity.swift
//  SwiftUI_PFinance
//
//  Created by Stanly Shiyanovskiy on 01.12.2020.
//

import CoreData
import Foundation

enum PaymentCategory: Int {
    case income = 0
    case expense = 1
}

@objc(PaymentActivity)
public class PaymentActivity: NSManagedObject {
    
    @NSManaged public var paymentId: UUID
    @NSManaged public var date: Date
    @NSManaged public var name: String
    @NSManaged public var address: String?
    @NSManaged public var amount: Double
    @NSManaged public var memo: String?
    @NSManaged public var typeNum: Int32
    
}

extension PaymentActivity: Identifiable {
    var type: PaymentCategory {
        get {
            return PaymentCategory(rawValue: Int(typeNum)) ?? .expense
        }
        
        set {
            typeNum = Int32(newValue.rawValue)
        }
    }
}
