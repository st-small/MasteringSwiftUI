//
//  ContentView.swift
//  SwiftUI_ProgressRing
//
//  Created by Stanly Shiyanovskiy on 09.12.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State var progress = 0.33
    
    var body: some View {
        VStack {
            ZStack {
                
                ProgressRingView(thickness: 30,
                                 width: 300,
                                 gradient: Gradient(colors: [.darkPurple, .lightPurple]),
                                 progress: $progress)
                
                ProgressRingView(thickness: 30,
                                 width: 235,
                                 gradient: Gradient(colors: [.darkYellow, .lightYellow]),
                                 progress: $progress)
                
                ProgressRingView(thickness: 30,
                                 width: 170,
                                 gradient: Gradient(colors: [.darkGreen, .lightGreen]),
                                 progress: $progress)
            }
            
            HStack {
                Group {
                    
                    Text("25%")
                        .font(.system(.headline, design: .rounded))
                        .onTapGesture {
                            progress = 0.25
                        }
                    
                    Text("50%")
                        .font(.system(.headline, design: .rounded))
                        .onTapGesture {
                            progress = 0.5
                        }
                    
                    Text("75%")
                        .font(.system(.headline, design: .rounded))
                        .onTapGesture {
                            progress = 0.75
                        }
                    
                    Text("100%")
                        .font(.system(.headline, design: .rounded))
                        .onTapGesture {
                            progress = 1.0
                        }
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
            }
            .padding(.top, 50)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
