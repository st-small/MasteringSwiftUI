//
//  SwiftUI_PFinanceApp.swift
//  SwiftUI_PFinance
//
//  Created by Stanly Shiyanovskiy on 01.12.2020.
//

import SwiftUI

@main
struct SwiftUI_PFinanceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
