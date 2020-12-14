//
//  ContentView.swift
//  SwiftUITinderApp
//
//  Created by Stanly Shiyanovskiy on 24.11.2020.
//

import SwiftUI

struct TopBarMenu: View {
    
    var body: some View {
        HStack {
            Image(systemName: "line.horizontal.3")
                .font(.system(size: 30))
            Spacer()
            Image(systemName: "mappin.and.ellipse")
                .font(.system(size: 35))
            Spacer()
            Image(systemName: "heart.circle.fill")
                .font(.system(size: 30))
        }
        .padding()
    }
}

struct BottomBarMenu: View {
    
    var body: some View {
        HStack {
            Image(systemName: "xmark")
                .font(.system(size: 30))
                .foregroundColor(.black)
            
            Button(action: {
                
            }) {
                Text("BOOK IT NOW")
                    .font(.system(.subheadline, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 15)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            
            .padding(.horizontal, 20)
            
            Image(systemName: "heart")
                .font(.system(size: 30))
                .foregroundColor(.black)
        }
    }
}

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
    
    var isPressing: Bool {
        switch self {
        case .pressing, .dragging:
            return true
        case .inactive:
            return false
        }
    }
}

struct ContentView: View {
    
    @State var cardViews: [CardView] = {
        
        var views = [CardView]()
        
        for index in 0..<2 {
            views.append(CardView(image: trips[index].image, title: trips[index].destination))
        }
        
        return views
    }()
    
    @State private var lastIndex = 1
    @State private var removalTransition = AnyTransition.trailingBottom
    @GestureState private var dragState = DragState.inactive
    
    private let dragThreshold: CGFloat = 80.0
    
    var body: some View {
        VStack {
            TopBarMenu()
            
            ZStack {
                ForEach(cardViews) { cardView in
                    cardView
                        .zIndex(isTopCard(cardView: cardView) ? 1 : 0)
                        .overlay(
                            ZStack {
                                Image(systemName: "x.circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 100))
                                    .opacity(dragState.translation.width < -dragThreshold && isTopCard(cardView: cardView) ? 1.0 : 0)
                                
                                Image(systemName: "heart.circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 100))
                                    .opacity(dragState.translation.width > dragThreshold && isTopCard(cardView: cardView) ? 1.0 : 0)
                            }
                        )
                        .offset(x: isTopCard(cardView: cardView) ? dragState.translation.width : 0, y: isTopCard(cardView: cardView) ? dragState.translation.height : 0)
                        .scaleEffect(dragState.isDragging && isTopCard(cardView: cardView) ? 0.95 : 1)
                        .rotationEffect(Angle(degrees: isTopCard(cardView: cardView) ? Double(dragState.translation.width / 10) : 0))
                        .animation(.interpolatingSpring(stiffness: 180, damping: 100))
                        .transition(removalTransition)
                        .gesture(LongPressGesture(minimumDuration: 0.01)
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
                                    .onChanged({ value in
                                        guard case .second(true, let drag?) = value else { return }
                                        
                                        if drag.translation.width < -dragThreshold {
                                            removalTransition = .leadingBottom
                                        }
                                        
                                        if drag.translation.width > dragThreshold {
                                            removalTransition = .trailingBottom
                                        }
                                    })
                                    .onEnded({ value in
                                        guard case .second(true, let drag?) = value else { return }
                                        
                                        if drag.translation.width < -dragThreshold || drag.translation.width > dragThreshold {
                                            
                                            moveCard()
                                        }
                                    })
                        )
                }
            }
            
            Spacer(minLength: 20)
            
            BottomBarMenu()
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default)
        }
    }
    
    private func isTopCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: { $0.id == cardView.id }) else { return false }
        return index == 0
    }
    
    private func moveCard() {
        cardViews.removeFirst()
        
        lastIndex += 1
        let trip = trips[lastIndex % trips.count]
        
        let newCardView = CardView(image: trip.image, title: trip.destination)
        
        cardViews.append(newCardView)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            TopBarMenu().previewLayout(.fixed(width: 375, height: 60))
            BottomBarMenu().previewLayout(.fixed(width: 375, height: 60))
        }
    }
}

extension AnyTransition {
    static var trailingBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity,
            removal: AnyTransition.move(edge: .trailing)
                .combined(with: .move(edge: .bottom)))
    }
    
    static var leadingBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity,
            removal: AnyTransition.move(edge: .leading)
                .combined(with: .move(edge: .bottom)))
    }
}
