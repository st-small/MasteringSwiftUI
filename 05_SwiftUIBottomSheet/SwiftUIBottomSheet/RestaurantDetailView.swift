//
//  RestaurantDetailView.swift
//  SwiftUIBottomSheet
//
//  Created by Stanly Shiyanovskiy on 19.11.2020.
//

import SwiftUI

enum DragState {
    case inactive
    case pressing
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(translation: let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .pressing, .dragging:
            return true
        case .inactive:
            return false
        }
    }
}

enum ViewState {
    case full
    case half
}

struct ScrollOffsetKey: PreferenceKey {
    
    typealias Value = CGFloat
    
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct HandleBar: View {
    
    var body: some View {
        Rectangle()
            .frame(width: 50, height: 5)
            .foregroundColor(Color(.systemGray5))
            .cornerRadius(10)
    }
}

struct HandleBar_Previews: PreviewProvider {
    static var previews: some View {
        HandleBar()
    }
}

struct TitleBar: View {
    
    var body: some View {
        HStack {
            Text("Restaurant Details")
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding()
    }
}

struct TitleBar_Previews: PreviewProvider {
    static var previews: some View {
        TitleBar()
    }
}

struct HeaderView: View {
    
    let restaurant: Restaurant
    
    var body: some View {
        Image(restaurant.image)
            .resizable()
            .scaledToFill()
            .frame(height: 300)
            .clipped()
            .overlay(
                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(restaurant.name)
                            .foregroundColor(.white)
                            .font(.system(.largeTitle, design: .rounded))
                            .bold()
                        
                        Text(restaurant.type)
                            .font(.system(.headline, design: .rounded))
                            .padding(5)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(5)
                    }
                    Spacer()
                }
                .padding()
            )
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(restaurant: restaurants[0])
    }
}

struct DetailInfoView: View {
    let icon: String?
    let info: String
    
    var body: some View {
        HStack {
            if icon != nil {
                Image(systemName: icon!)
                    .padding(.trailing, 10)
            }
            Text(info)
                .font(.system(.body, design: .rounded))
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct DetailInfoView_Preview: PreviewProvider {
    static var previews: some View {
        DetailInfoView(icon: "map",
                       info: restaurants[0].description)
    }
}

struct RestaurantDetailView: View {
    
    let restaurant: Restaurant
    
    @GestureState private var dragState = DragState.inactive
    @State private var positionOffset: CGFloat = 0
    @State private var viewState = ViewState.half
    @State private var scrollOffset: CGFloat = 0
    
    @Binding var isShow: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                HandleBar()
                
                ScrollView(.vertical) {
                    
                    GeometryReader { scrollViewProxy in
                        Color.clear.preference(key: ScrollOffsetKey.self, value: scrollViewProxy.frame(in: .named("scrollview")).minY)
                        //                        Text("\(scrollViewProxy.frame(in: .named("scrollView")).minY)")
                    }
                    .frame(height: 0)
                    
                    VStack {
                        TitleBar()
                        
                        HeaderView(restaurant: restaurant)
                        
                        DetailInfoView(icon: "map", info: restaurant.location)
                        DetailInfoView(icon: "phone", info: restaurant.phone)
                        DetailInfoView(icon: nil, info: restaurant.description)
                            .padding(.top)
                            .padding(.bottom, 100)
                    }
                    .offset(y: -scrollOffset)
                    .animation(nil)
                }
                .background(Color.white)
                .cornerRadius(10, antialiased: true)
                .disabled(viewState == .half)
                .coordinateSpace(name: "scrollview")
            }
            .offset(y: geometry.size.height/2 + dragState.translation.height + positionOffset)
            .offset(y: scrollOffset)
            .animation(.interpolatingSpring(stiffness: 200, damping: 25, initialVelocity: 10))
            .edgesIgnoringSafeArea(.all)
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                
                if viewState == .full {
                    scrollOffset = value > 0 ? value : 0
                    
                    if scrollOffset > 120 {
                        positionOffset = 0
                        viewState = .half
                        scrollOffset = 0
                    }
                }
            }
            .gesture(
                DragGesture()
                    .updating($dragState, body: { value, state, transaction in
                        state = .dragging(translation: value.translation)
                    }
                )
                    .onEnded({ value in
                        
                        if viewState == .half {
                            // Threshold #1
                            // Slide up and when it goes beyond the threshold
                            // change the view state to fully opened by updating
                            // the position offset
                            if value.translation.height < -geometry.size.height * 0.25 {
                                positionOffset = -geometry.size.height/2 + 50
                                viewState = .full
                            }
                            
                            // Threshold #2
                            // Slide down and when it goes pass the threshold
                            // dismiss the view by setting isShow to false
                            if value.translation.height > geometry.size.height * 0.3 {
                                isShow = false
                            }
                        }
                    }
                )
            )
        }
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(restaurant: restaurants[0], isShow: .constant(true))
            .background(Color.black.opacity(0.3))
            .edgesIgnoringSafeArea(.all)
    }
}
