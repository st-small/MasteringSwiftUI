//
//  SwapCircles.swift
//  SwiftUI_MatchedGeometry
//
//  Created by Stanly Shiyanovskiy on 10.12.2020.
//

import SwiftUI

struct SwapCircles: View {
    
    @State private var swap = false
    
    @Namespace private var dotTransition
    
    var body: some View {
        if swap {
            
            // After swap
            // Green dot on the left, Orange dot on the right
            
            HStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 30, height: 30)
                    .matchedGeometryEffect(id: "greenCircle", in: dotTransition)
                
                Spacer()
                
                Circle()
                    .fill(Color.orange)
                    .frame(width: 30, height: 30)
                    .matchedGeometryEffect(id: "orangeCircle", in: dotTransition)
            }
            .frame(width: 100)
            .animation(.linear)
            .onTapGesture {
                swap.toggle()
            }
            
        } else {
            
            // Start state
            // Orange dot on the left, Green dot on the right
            
            HStack {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 30, height: 30)
                    .matchedGeometryEffect(id: "orangeCircle", in: dotTransition)
                
                Spacer()
                
                Circle()
                    .fill(Color.green)
                    .frame(width: 30, height: 30)
                    .matchedGeometryEffect(id: "greenCircle", in: dotTransition)
            }
            .frame(width: 100)
            .animation(.linear)
            .onTapGesture {
                swap.toggle()
            }
        }
    }
}

struct SwapCircles_Previews: PreviewProvider {
    static var previews: some View {
        SwapCircles()
    }
}
