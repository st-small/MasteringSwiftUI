//
//  SwiftUIPracticeApp.swift
//  SwiftUIPractice
//
//  Created by Stanly Shiyanovskiy on 14.11.2020.
//

import SwiftUI

@main
struct SwiftUIPracticeApp: App {
    
    let store = SettingStore()
    
    var body: some Scene {
        WindowGroup {
            FormSampleView().environmentObject(store)
        }
    }
}
