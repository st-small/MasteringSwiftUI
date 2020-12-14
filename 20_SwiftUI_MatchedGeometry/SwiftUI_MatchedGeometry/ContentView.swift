//
//  ContentView.swift
//  SwiftUI_MatchedGeometry
//
//  Created by Stanly Shiyanovskiy on 10.12.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var expand = false
    
    @Namespace private var shapeTransition
    
    var body: some View {
        VStack {
            if expand {
                
                // Rounded Rectangle
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 50.0)
                    .matchedGeometryEffect(id: "circle", in: shapeTransition)
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 300)
                    .padding()
                    .foregroundColor(Color(.systemGreen))
                    .animation(.easeInOut)
                    .onTapGesture {
                        expand.toggle()
                    }
            } else {
                
                // Circle
                RoundedRectangle(cornerRadius: 50)
                    .matchedGeometryEffect(id: "circle", in: shapeTransition)
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(.systemOrange))
                    .animation(.easeIn)
                    .onTapGesture {
                        expand.toggle()
                    }
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
