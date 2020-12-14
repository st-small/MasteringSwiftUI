//
//  ContentView.swift
//  SwiftUIGestures
//
//  Created by Stanly Shiyanovskiy on 19.11.2020.
//

import SwiftUI

/*
struct ContentView: View {
    
    @State private var isPressed = false
    @GestureState private var longPressTap = false
    
    var body: some View {
        Image(systemName: "star.circle.fill")
            .font(.system(size: 200))
            .opacity(longPressTap ? 0.4 : 1.0)
            .scaleEffect(isPressed ? 0.5 : 1.0)
            .animation(.easeInOut)
            .foregroundColor(.green)
            //            .gesture(
            //                TapGesture()
            //                    .onEnded({
            //                        isPressed.toggle()
            //                    })
            //            )
            
            //            .gesture(
            //                LongPressGesture(minimumDuration: 1.0)
            //                    .onEnded({ _ in
            //                        isPressed.toggle()
            //                    })
            //            )
            
            .gesture(
                LongPressGesture(minimumDuration: 1.0)
                    .updating($longPressTap, body: { (currentState, state, transaction) in
                        state = currentState
                    })
                    .onEnded({ _ in
                        isPressed.toggle()
                    })
            )
    }
}
*/

enum DragState {
    case inactive
    case pressing
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive, .pressing: return .zero
        case .dragging(let translation): return translation
        }
    }
    
    var isPressing: Bool {
        switch self {
        case .pressing, .dragging: return true
        case .inactive: return false
        }
    }
}

struct ContentView: View {
    
    @GestureState private var dragState = DragState.inactive
    @State private var position = CGSize.zero
    
    var body: some View {
        Image(systemName: "star.circle.fill")
            .font(.system(size: 100))
            .opacity(dragState.isPressing ? 0.5 : 1.0)
            .offset(x: position.width + dragState.translation.width, y: position.height + dragState.translation.height)
            .animation(.easeInOut)
            .foregroundColor(.green)
            .gesture(
                LongPressGesture(minimumDuration: 1)
                    .sequenced(before: DragGesture())
                    .updating($dragState, body: { value, state, transaction in
                        
                        switch value {
                        case .first(true):
                            state = .pressing
                        case .second(true, let drag):
                            state = .dragging(translation: drag?.translation ?? .zero)
                        default: break
                        }
                    })
                    .onEnded({ value in
                        guard case .second(true, let drag?) = value else {
                            return
                        }
                        
                        position.width += drag.translation.width
                        position.height += drag.translation.height
                    })
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
