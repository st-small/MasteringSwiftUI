//
//  ContentView.swift
//  SwiftUI_AppStore
//
//  Created by Stanly Shiyanovskiy on 02.12.2020.
//

import SwiftUI


struct ContentView: View {
    
    @State private var showContents: [Bool] = Array(repeating: false, count: sampleArticles.count)
    
    enum ContentMode {
        case list
        case content
    }

    private var contentMode: ContentMode {
        showContents.contains(true) ? .content : .list
    }
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                VStack(spacing: 40) {
                    
                    TopBarView()
                        .padding(.horizontal, 20)
                        .opacity(contentMode == .content ? 0 : 1)
                    
                    ForEach(sampleArticles.indices) { index in
                        GeometryReader { inner in
                            ArticleCardView(
                                category: sampleArticles[index].category,
                                headline: sampleArticles[index].headline,
                                subHeadline: sampleArticles[index].subHeadline,
                                image: sampleArticles[index].image,
                                content: sampleArticles[index].content,
                                isShowContent: $showContents[index]
                            )
                            .offset(y: showContents[index] ? -inner.frame(in: .global).minY : 0)
                            .padding(.horizontal, showContents[index] ? 0 : 20)
                            .opacity(
                                contentMode == .list || contentMode == .content && showContents[index] ? 1 : 0
                            )
                            .onTapGesture {
                                showContents[index] = true
                            }
                        }
                        .frame(height: showContents[index] ? fullView.size.height + fullView.safeAreaInsets.top + fullView.safeAreaInsets.bottom : min(sampleArticles[index].image.size.height / 3, 500))
                        .animation(.interactiveSpring(response: 0.55, dampingFraction: 0.65, blendDuration: 0.1))
                    }
                }
                .frame(width: fullView.size.width)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TopBarView: View {
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            VStack(alignment: .leading) {
                Text(getCurrentDate().uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("Today")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            }
            
            Spacer()
            
            AvatarView(image: "profile", width: 40, height: 40)
        }
    }
    
    func getCurrentDate(with format: String = "EEEE, MMM d") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: Date())
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
    }
}

struct AvatarView: View {
    
    let image: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: width, height: height)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(image: "profile", width: 40, height: 40)
    }
}

