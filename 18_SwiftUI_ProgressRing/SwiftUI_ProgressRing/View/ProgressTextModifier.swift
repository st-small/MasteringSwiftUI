//
//  ProgressTextModifier.swift
//  SwiftUI_ProgressRing
//
//  Created by Stanly Shiyanovskiy on 09.12.2020.
//

import SwiftUI

struct ProgressTextModifier: AnimatableModifier {
    
    var progress: Double = 0.0
    var textColor: Color = .primary
    
    private var progressText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.percentSymbol = "%"
        
        return formatter.string(from: NSNumber(value: progress)) ?? ""
    }
    
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Text(progressText)
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(textColor)
                    .animation(nil)
            )
    }
}

extension View {
    func animatableProgressText(progress: Double, textColor: Color = .primary) -> some View {
        modifier(ProgressTextModifier(progress: progress, textColor: textColor))
    }
}
