//
//  SwiftUI_ToDoListApp.swift
//  SwiftUI_ToDoList
//
//  Created by Stanly Shiyanovskiy on 30.11.2020.
//

import SwiftUI

@main
struct SwiftUI_ToDoListApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
