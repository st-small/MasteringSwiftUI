//
//  StateSampleView.swift
//  SwiftUIPractice
//
//  Created by Stanly Shiyanovskiy on 15.11.2020.
//

import SwiftUI

struct StateSampleView: View {
    
    @State private var isPlaying = false
    @State private var counter = 1
    
    @State private var counterBlue = 0
    @State private var counterGreen = 0
    @State private var counterRed = 0
    
    var body: some View {
        ScrollView {
            VStack {
                Button(action: {
                    isPlaying.toggle()
                }) {
                    Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                        .font(.system(size: 150))
                        .foregroundColor(isPlaying ? .red : .green)
                }
                CounterButton(counter: $counter, color: .red)
                Text("\(counterBlue + counterGreen + counterRed)")
                    .font(.system(size: 220, weight: .bold, design: .rounded))
                HStack {
                    CounterButton(counter: $counterBlue, color: .blue)
                    CounterButton(counter: $counterGreen, color: .green)
                    CounterButton(counter: $counterRed, color: .red)
                }
            }
        }
    }
}

struct CounterButton: View {
    
    @Binding var counter: Int
    var color: Color
    
    var body: some View {
        Button(action: {
                self.counter += 1
        }) {
            Circle()
                .frame(width: 120, height: 120)
                .foregroundColor(color)
                .overlay(
                    Text("\(counter)")
                        .font(.system(size: 70, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                )
        }
    }
}



struct StateSampleView_Previews: PreviewProvider {
    static var previews: some View {
        StateSampleView()
    }
}
